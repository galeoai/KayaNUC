module KayaNUC

using Images, ImageMagick # loading tif files
using Statistics
using CSV, Tables
using HDF5

export make_nuc_tables

"""
    load images tif from kaya experiment 
"""
function load_tif(path)
    files = readdir(path)
    filter!(x->occursin(r".tif$",x),files)
    [load(joinpath(path,file))|>x->gray.(x) for file in files]
end


struct NUC{T}
    offset::Array{T,2}
    gain::Array{T,2}
end

function calc_nuc(dark_stack, flat_stack)
    offset = mean(dark_stack)
    flat = mean(flat_stack)
    gain = (mean(flat)-mean(offset))./(flat.-offset)
    NUC(offset,gain)
end

function calc_nuc_tif(dark_stack_path::String, flat_stack_path::String)
    dark_stack = load_tif(dark_stack_path) 
    flat_stack = load_tif(flat_stack_path)
    return calc_nuc(dark_stack,flat_stack)
end

function save(nuc::NUC,format)
    if format=="csv"
        CSV.write("gain.csv"  ,Tables.table(nuc.gain)  , writeheader=false)
        CSV.write("offset.csv",Tables.table(nuc.offset), writeheader=false)
    elseif format=="hdf5"
        h5open("nuc_tables.h5", "w") do file
            write(file, "offset", nuc.offset)
            write(file, "gain", nuc.gain)
        end
    end
end

function make_nuc_tables(dark_stack_path::String, flat_stack_path::String)
    nuc = calc_nuc_tif(dark_stack_path::String, flat_stack_path::String)
    save(nuc,"hdf5")
end


end # module
