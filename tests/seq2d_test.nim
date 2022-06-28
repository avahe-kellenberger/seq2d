import nimtest

import seq2d

describe "Seq2D":

  it "`width` returns the correct width":
    let grid = newSeq2D[int](10, 20)
    assertEquals(grid.width, 10)

  it "`height` returns the correct height":
    let grid = newSeq2D[int](30, 123)
    assertEquals(grid.height, 123)

  it "inserting data in a particular place only sets data in that place":
    var grid = newSeq2D[int](15, 17)
    grid[3, 8] = 1

    for (x, y, value) in grid:
      if x == 3 and y == 8:
        assertEquals(value, 1)
      else:
        assertEquals(value, 0)

