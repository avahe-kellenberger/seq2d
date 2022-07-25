when compileOption("checks"):
  import strformat

type Seq2D*[T] = object
  data: seq[T]
  width: int
  height: int

proc newSeq2D*[T](width, height: int): Seq2D[T] =
  result = Seq2D[T]()
  result.data = newSeq[T](width * height)
  result.width = width
  result.height = height

template `width`*[T](this: Seq2D[T]): int =
  this.width

template `height`*[T](this: Seq2D[T]): int =
  this.height

template checkForBoundsException[T](this: Seq2D[T], x, y: int) =
  when compileOption("checks"):
    if x >= this.width:
      raise newException(IndexDefect, fmt"x value of {x} outside bounds")
    if y >= this.height:
      raise newException(IndexDefect, fmt"y value of {y} outside bounds")

proc `[]`*[T](this: Seq2D[T], x, y: int): T {.inline.} =
  this.checkForBoundsException(x, y)
  return this.data[x + this.width * y]

proc `[]`*[T](this: var Seq2D[T], x, y: int): var T {.inline.} =
  this.checkForBoundsException(x, y)
  return this.data[x + this.width * y]

proc `[]=`*[T](this: var Seq2D[T], x, y: int, t: T) {.inline.} =
  this.checkForBoundsException(x, y)
  this.data[x + this.width * y] = t

iterator items*[T](this: Seq2D[T]): tuple[x: int, y: int, value: T] =
  for y in 0 ..< this.height:
    for x in 0 ..< this.width:
      yield (x, y, this[x, y])

iterator mitems*[T](this: var Seq2D[T]): tuple[x: int, y: int, value: var T] =
  for y in 0 ..< this.height:
    for x in 0 ..< this.width:
      yield (x, y, this[x, y])

iterator values*[T](this: Seq2D[T]): T =
  for item in this.data:
    yield item

proc clear*[T](this: var Seq2D[T]) =
  for t in this.data.mitems:
    reset(t)

