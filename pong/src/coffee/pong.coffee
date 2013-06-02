# main object for storing state/whatever
Pong = {}


# set up constants
Pong.constants =
  MAX_VELOCITY: 20
  IMPULSE: 10
  DRAG: 5/6


$(document).ready ->
  Pong.canvas = $("#pong")[0]
  Pong.context = Pong.canvas.getContext("2d")

  Pong.initializeStructure()
  Pong.initializeGraphics()
  Pong.initializeInput()

  # set up the main game loop
  Pong.gameLoop = ->
    Pong.drawFrame()

  # kick off the game loop
  Pong.gameLoop()
