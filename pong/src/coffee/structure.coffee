Pong.initializeStructure = ->
  Pong.center =
    x: Pong.canvas.width / 2
    y: Pong.canvas.height / 2

  # start the ball in the center of the screen
  Pong.ball =
    position:
      x: Pong.center.x
      y: Pong.center.y
    radius: 10

  # set up the paddles
  Pong.paddles =
    left:
      length: 100
      momentum: 0
      position:
        x: 5
        y: Pong.center.y
      velocity: 0.0
      width: 10
    right:
      length: 100
      momentum: 0
      position:
        x: Pong.canvas.width - 15
        y: Pong.center.y
      velocity: 0.0
      width: 10

  # set up player state
  Pong.players =
    one:
      paddle: Pong.paddles.left
      score: 0
    two:
      paddle: Pong.paddles.right
      score: 0

