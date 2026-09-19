"""Bake precise map labels into Oulsen nogrid RSC7/DXT5 tiles.
Requires Python 3, Pillow >= 12, numpy and matplotlib.
Input MUST be the original nogrid YTD files, not already labelled files.
Usage: python tools/build_map.py --source ORIGINAL_NOGRID --output stream --preview PREVIEWS
Unsupported layouts are rejected rather than rewritten.
"""
import argparse, io, json, struct, zlib
from pathlib import Path
import numpy as np
from PIL import Image
import matplotlib
matplotlib.use('Agg')
from matplotlib.figure import Figure
from matplotlib.backends.backend_agg import FigureCanvasAgg

ROOT=Path(__file__).resolve().parents[1]
SIZE=4096
SYS_SIZE=8192
DATA_SIZE=SIZE*SIZE # BC3/DXT5 = 16 bytes per 4x4 block.

def dds(data):
    # Standard DDS header, one DXT5 level.
    header=bytearray(128)
    header[:4]=b'DDS '
    struct.pack_into('<7I',header,4,124,0x81007,SIZE,SIZE,DATA_SIZE,0,1)
    struct.pack_into('<II4s',header,76,32,4,b'DXT5')
    struct.pack_into('<I',header,108,0x1000)
    return bytes(header)+data

def unpack(path):
    packed=path.read_bytes()
    assert packed[:8]==b'RSC7\r\0\0\0', f'Unsupported resource: {path}'
    body=zlib.decompress(packed[16:],-15)
    assert len(body)==SYS_SIZE+DATA_SIZE, f'Unsupported length: {path}'
    assert struct.unpack_from('<HH',body,0x90)==(SIZE,SIZE), f'Unsupported size: {path}'
    assert body[0x98:0x9c]==b'DXT5' and body[0x9d]==1, f'Unsupported format/mips: {path}'
    assert struct.unpack_from('<Q',body,0xb0)[0]==0x60000000, f'Unsupported pointer: {path}'
    return packed[:16],body

def render_overlay(labels,row,col):
    fig=Figure(figsize=(SIZE/100,SIZE/100),dpi=100,facecolor=(0,0,0,0))
    canvas=FigureCanvasAgg(fig)
    for label in labels:
        px=(label['x']+4140)/4500*SIZE-col*SIZE
        py=(8400-label['y'])/4500*SIZE-row*SIZE
        # All tiles render the same global layer, so labels crossing seams join exactly.
        if px < -1200 or px > SIZE+1200 or py < -200 or py > SIZE+200:continue
        fig.text(px/SIZE,1-py/SIZE,label['text'],ha='center',va='center',
                 fontsize=label['size']*72/100,fontfamily='DejaVu Sans',fontweight='bold',
                 color='#fff8eb',bbox=dict(boxstyle='round,pad=0.24',facecolor='#14262e',
                 edgecolor='#dfa75c',linewidth=1.2,alpha=0.92))
    canvas.draw()
    return Image.fromarray(np.array(canvas.buffer_rgba()))

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--source',type=Path,required=True)
    ap.add_argument('--output',type=Path,required=True);ap.add_argument('--preview',type=Path,required=True)
    args=ap.parse_args();assert args.source.resolve()!=args.output.resolve(),'Separate input and output required'
    args.output.mkdir(parents=True,exist_ok=True);args.preview.mkdir(parents=True,exist_ok=True)
    labels=json.loads((ROOT/'kaartnamen.json').read_text())
    records=[]
    for row in range(3):
        for col in range(2):
            overlay=render_overlay(labels,row,col)
            mask=np.asarray(overlay.getchannel('A'))>0
            blocks=mask.reshape(SIZE//4,4,SIZE//4,4).any(axis=(1,3))
            for prefix in ['minimap','minimap_sea']:
                name=f'{prefix}_{row}_{col}.ytd'
                header,body=unpack(args.source/name)
                original=Image.open(io.BytesIO(dds(body[SYS_SIZE:]))).convert('RGBA')
                result=Image.alpha_composite(original,overlay)
                encoded=io.BytesIO();result.save(encoded,format='DDS',pixel_format='DXT5')
                encoded=encoded.getvalue();assert len(encoded)==DATA_SIZE+128 and encoded[84:88]==b'DXT5'
                old=np.frombuffer(body[SYS_SIZE:],dtype=np.uint8).reshape(SIZE//4,SIZE//4,16)
                new=np.frombuffer(encoded[128:],dtype=np.uint8).reshape(SIZE//4,SIZE//4,16)
                patched=old.copy();patched[blocks]=new[blocks]
                assert np.array_equal(patched[~blocks],old[~blocks]),'Unlabelled blocks changed'
                newbody=body[:SYS_SIZE]+patched.tobytes()
                co=zlib.compressobj(9,zlib.DEFLATED,-15)
                packed=header+co.compress(newbody)+co.flush()
                target=args.output/name;target.write_bytes(packed)
                checkheader,checkbody=unpack(target)
                assert checkheader==header and checkbody==newbody
                records.append(dict(file=name,modified_blocks=int(blocks.sum()),total_blocks=int(blocks.size),
                                    unchanged_outside_labels=True,header_and_metadata_preserved=True))
                if prefix=='minimap':
                    # Preview is decoded from actual output bytes, not the pre-compression drawing.
                    preview=Image.open(io.BytesIO(dds(checkbody[SYS_SIZE:]))).convert('RGB')
                    preview.resize((1536,1536),Image.Resampling.LANCZOS).save(args.preview/f'tile_{row}_{col}.jpg',quality=92)
                    if row==2 and col==0:
                        preview.crop((2200,0,4096,1400)).save(args.preview/'gemert_detail.png')
            print(f'Tile {row}_{col}: verified both dictionaries',flush=True)
    (args.preview/'texture-checks.json').write_text(json.dumps(records,indent=2)+'\n')
    montage=Image.new('RGB',(3072,4608))
    for row in range(3):
        for col in range(2):montage.paste(Image.open(args.preview/f'tile_{row}_{col}.jpg'),(col*1536,row*1536))
    montage.save(args.preview/'gemert_satelliet_overzicht.jpg',quality=94)
    print(f'{len(labels)} labels; {len(records)} verified YTD files.')

if __name__=='__main__':main()
