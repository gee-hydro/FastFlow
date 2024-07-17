using Printf
using Dates
using GDAL
using DataStructures

"""
  fillDEMAndComputeFlowDirection(dem::AbstractMatrix)

#! dem was modified!

fill_depressions_wang_and_liu

Wang&Liu(2006) to fill depressions
"""
function fillDEMAndComputeFlowDirection(dem::AbstractMatrix)
  nrow, ncol = size(dem)
  isProcessed = false(nrow, ncol)
  flowdir = zeros(UInt8, nrow, ncol)

  queue = PriorityQueue{Tuple{Int,Int},Int}(Base.Order.Reverse)
  n_valid = 0
  
  # Push all border cells into the queue
  @inbounds for i in 1:ncol, j in 1:nrow
    !isnan(dem[i, j]) && continue
    n_valid += 1

    for k in 1:8
      i2, j2 = row_goto(i, k), col_goto(j, k)
      if !InGrid(i2, j2, nrow, ncol) || isnan(dem[i2, i2])
        queue[i, j] = dem[i, j]
        isProcessed[i, j] = true
        break # ? might bug, 为何跳出for loop
      end
    end
  end

  count = 0
  while !isempty(queue)
    count += 1
    (i, j), spill = pop!(queue)

    for k in 1:8
      i2, j2 = row_goto(i, k), col_goto(j, k)
      !InGrid(i2, j2, nrow, ncol) && continue

      if !isnan(dem[i2, j2]) && !isProcessed[i2, j2]

        iSpill = dem[i2, j2] # next 低地
        if iSpill <= spill
          flowdir[i2, j2] = inverser[k]
        else
          spill = iSpill # 碰到了洼地
        end
        
        isProcessed[i2, j2] = true
        dem[i2, j2] = spill
        queue[i2, j2] = spill
      end
    end
  end
  # 填洼对流向的影响
  dem, flowdir
end
