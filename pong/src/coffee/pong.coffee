$(document).ready ->
  # main object for storing state/whatever
  pong = {}

  pong.canvas = $("#pong")[0]
  pong.context = pong.canvas.getContext("2d")
  pong.center =
    x: pong.canvas.width / 2
    y: pong.canvas.height / 2

  # start the ball in the center of the screen
  pong.ball =
    radius: 10
    position:
      x: pong.center.x
      y: pong.center.y
