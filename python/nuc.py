import numpy as np
import h5py

import os
from PIL import Image

def apply_nuc(image, offset, gain):
    """
    inputs: 
    image - [N,M] ndarray 
    offset - [N,M] ndarray float
    gain - [N,M] ndarray  float
    output: 
    nucced image with the same type of image 
    """
    nucced = (image-offset)*gain
    pixel_max = np.iinfo(img.dtype).max
    np.clip(nucced,0,pixel_max,out=nucced)
    return nucced.astype(image.dtype)
    
def load_nuc(filename):
    """
    load the NUC tables (gain, offset) from h5 file 
    inputs:
    filename - string
    output: 
    offset, gain tuple of ndarray 
    """
    f = h5py.File(filename)
    offset = np.array(f["offset"])
    gain = np.array(f["gain"])
    return (offset, gain)

def load_tif(dir_path):
    images = os.listdir(dir_path)
    images.sort()
    images = [f for f in images if f.endswith(".tif")]
    return [np.array(Image.open(dir_path+f)) for f in images]

def make_nuc_tables(dark_dir, flat_dir):
    dark_stack = load_tif(dark_dir)
    flat_stack = load_tif(flat_dir)
    offset = np.mean(dark_stack,axis=0)
    flat = np.mean(flat_stack, axis=0)
    gain = (np.mean(flat)-np.mean(offset))/(flat-offset)
    return offset, gain

def save_nuc_tables(offset,gain):
    with h5py.File('nuc_tables.h5', 'w') as hf:
        hf.create_dataset("offset",  data=offset)
        hf.create_dataset("gain",  data=gain)
    return


if __name__ == '__main__':
    # read image
    path = r'./data/raw.tif'
    img = np.array(Image.open(path))
    # read nuc_tables
    path = r'./data/nuc_tables.h5'
    offset, gain = load_nuc(path)
    nuc_img = apply_nuc(img,offset,gain)

