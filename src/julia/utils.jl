const DX = [0, 1, 1, 1, 0, -1, -1, -1]
const DY = [1, 1, 0, -1, -1, -1, 0, 1]

"""
  row_goto(k::Int, row::Int)::Int
  col_goto(k::Int, col::Int)::Int

# Arguments
- `k`: 8-neighbor
  6  7  8
  5     1
  4  3  2
"""
row_goto(row::Int, k::Int)::Int = row + DX[k]

col_goto(col::Int, k::Int)::Int = col + DY[k]

function InGrid(i::Int, j::Int, nrow::Int, ncol::Int)
  1 <= i <= nrow && 1 <= j <= ncol
end
