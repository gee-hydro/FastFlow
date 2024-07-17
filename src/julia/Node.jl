# module NodeModule
export Node

struct Node
  row::Int
  col::Int
  spill::Float32
  Node() = new(0, 0, -9999.0f0)
end

Base.:(==)(n1::Node, n2::Node) = n1.col == n2.col && n1.row == n2.row
Base.:(!=)(n1::Node, n2::Node) = n1.col != n2.col || n1.row != n2.row
Base.:(<)(n1::Node, n2::Node) = n1.spill < n2.spill
Base.:(>)(n1::Node, n2::Node) = n1.spill > n2.spill
Base.:(>=)(n1::Node, n2::Node) = n1.spill >= n2.spill
Base.:(<=)(n1::Node, n2::Node) = n1.spill <= n2.spill

# end # module NodeModule
