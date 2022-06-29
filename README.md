# Seq2D

Two-dimensional array implementation.


## Usage

```nim
var grid = newSeq2D[int](5, 6)

# Set data at a particular point in the "grid"
grid[2, 3] = 14

doAssert(grid[2, 3] == 14)

# Iterate over the grid
for x, y, value in grid.items:
  echo "[" & $x & ", " & $y & "] = " & $value

# Items can be mutated using `mitems`
for x, y, value in grid.mitems:
  if x mod 2 == 0:
    value = 1
```
