# module FlowDirectionModule
export FlowDirection

const NODATA = 0x00
const indexDir = [1, 2, 4, 8, 16, 32, 64, 128]

Base.@kwdef mutable struct FlowDirection
  width::Int = 0
  height::Int = 0
  pDir::Array{UInt8,2} = zeros(UInt8, width, height)
end

asByte(fd::FlowDirection, i::Int, j::Int)::UInt8 = fd.pDir[i, j]

function set_value(fd::FlowDirection, i::Int, j::Int, z::UInt8)
  fd.pDir[i, j] = z
end

is_NoData(fd::FlowDirection, i::Int, j::Int)::Bool = fd.pDir[i, j] == NODATA

assign_NoData(fd::FlowDirection) = fill!(fd.pDir, NODATA)

get_NY(fd::FlowDirection)::Int = fd.height
get_NX(fd::FlowDirection)::Int = fd.width

getData(fd::FlowDirection) = fd.pDir

setHeight(fd::FlowDirection, height::Int) = (fd.height = height)
setWidth(fd::FlowDirection, width::Int) = (fd.width = width)

is_InGrid(fd::FlowDirection, i::Int, j::Int)::Bool = 
  1 <= i <= fd.height && 1 <= j <= fd.width

function getLength(dir::UInt)::Float64
  return (dir & 0x1) == 1 ? 1.41421 : 1.0
end




function nextCell(fd::FlowDirection, row::UInt, col::UInt, dir::UInt8)
  iDir = findfirst(==(dir), indexDir) - 1
  if iDir == -1
    return (false, row, col)
  end
    
  iRow = get_rowTo(iDir, row)
  iCol = get_colTo(iDir, col)

  if is_InGrid(fd, iRow, iCol) && !is_NoData(fd, iRow, iCol)
    return (true, iRow, iCol)
  else
    return (false, row, col)
  end
end




# end # module FlowDirectionModule
