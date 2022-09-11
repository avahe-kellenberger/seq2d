# Package

version       = "0.1.1"
author        = "Avahe Kellenberger"
description   = "A 2D Sequence Implementation"
license       = "GPL-2.0-only"
srcDir        = "src"

# Dependencies

requires "nim >= 1.6.4"
requires "nimtest >= 0.1.2"

task runtests, "Runs the test suite":
  exec "nimtest"
