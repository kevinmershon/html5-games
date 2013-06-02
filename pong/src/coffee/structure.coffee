pong.initializeStructure = ->
  pong.center =
    x: pong.canvas.width / 2
    y: pong.canvas.height / 2

  # start the ball in the center of the screen
  pong.ball =
    radius: 10
    position:
      x: pong.center.x
      y: pong.center.y

  # set up the paddles
  pong.paddles =
    left:
      length: 100
      width: 10
      position:
        x: 5
        y: pong.center.y
    right:
      length: 100
      width: 10
      position:
        x: pong.canvas.width - 15
        y: pong.center.y

  # set up player state
  pong.players =
    one:
      velocity: 0.0
      score: 0
      paddle: pong.paddles.left
    two:
      velocity: 0.0
      score: 0
      paddle: pong.paddles.right

