# main object for storing state/whatever
pong = {}


# set up constants
pong.constants =
  MAX_VELOCITY: 20
  IMPULSE: 10
  DRAG: 5/6


$(document).ready ->
  pong.canvas = $("#pong")[0]
  pong.context = pong.canvas.getContext("2d")

  pong.initializeStructure()
  pong.initializeGraphics()
  pong.initializeInput()

  # set up the main game loop
  pong.gameLoop = ->
    pong.drawFrame()

  # kick off the game loop
  pong.gameLoop()
