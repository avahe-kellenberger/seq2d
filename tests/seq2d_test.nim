import nimtest

import seq2d

describe "Seq2D":

  describe "width":
    it "returns the correct width":
      let grid = newSeq2D[int](10, 20)
      assertEquals(grid.width, 10)

  describe "height":
    it "returns the correct height":
      let grid = newSeq2D[int](30, 123)
      assertEquals(grid.height, 123)

  describe "[]":
    it "accessing data out of bounds raises an exception":
      var grid = newSeq2D[int](2, 2)

      # Does not raise
      discard grid[0, 0]

      assertRaises(IndexDefect, "index 6 not in 0 .. 3"):
        discard grid[2, 2]

  describe "[]=":
    it "inserting data out of bounds raises an exception":
      var grid = newSeq2D[int](2, 2)

      assertRaises(IndexDefect, "index 4 not in 0 .. 3"):
        grid[0, 2] = 1

      assertRaises(IndexDefect, "index -2 not in 0 .. 3"):
        grid[0, -1] = 1

    it "inserting data in a particular place only sets data in that place":
      var grid = newSeq2D[int](15, 17)
      grid[3, 8] = 1

      for (x, y, value) in grid:
        if x == 3 and y == 8:
          assertEquals(value, 1)
        else:
          assertEquals(value, 0)

  describe "items":

    it "iterates over all items":
      var grid = newSeq2D[int](2, 2)
      grid[0, 0] = 0
      grid[1, 0] = 1
      grid[0, 1] = 2
      grid[1, 1] = 3

      var count = 0
      for x, y, value in grid.items:
        assertEquals(value, x + grid.width * y)
        inc count
      assertEquals(count, grid.width * grid.height)

  describe "mitems":

    it "allows items to be modified while iterating":
      var grid = newSeq2D[int](10, 20)
      grid[1, 3] = 1

      for x, y, value in grid.mitems:
        if value == 1:
          value = 2

      assertEquals(grid[1, 3], 2)

  describe "clear":

    it "resets all values to default without changing the internal length":
      var grid = newSeq2D[int](2, 2)
      grid[0, 0] = 1
      grid[0, 1] = 1
      grid[1, 0] = 1
      grid[1, 1] = 1

      grid.clear()

      assertEquals(grid[0, 0], 0)
      assertEquals(grid[0, 1], 0)
      assertEquals(grid[1, 0], 0)
      assertEquals(grid[1, 1], 0)

