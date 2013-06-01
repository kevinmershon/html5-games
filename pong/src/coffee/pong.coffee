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

  # set up a helper function for drawing the ball
  pong.drawBall = ->
    pong.context.beginPath()
    pong.context.arc(
      pong.ball.position.x,
      pong.ball.position.y,
      pong.ball.radius,
      0,
      2 * Math.PI,
      false
    )
    pong.context.fillStyle = "white"
    pong.context.fill()

  pong.drawPaddles = ->
    pong.context.beginPath()

    # left paddle
    pong.context.rect(
      pong.paddles.left.position.x,
      pong.paddles.left.position.y - pong.paddles.left.length/2,
      pong.paddles.left.width,
      pong.paddles.left.length
    )
    pong.context.fillStyle = "white"
    pong.context.fill()

    # right paddle
    pong.context.rect(
      pong.paddles.right.position.x,
      pong.paddles.right.position.y - pong.paddles.right.length/2,
      pong.paddles.right.width,
      pong.paddles.right.length
    )
    pong.context.fillStyle = "white"
    pong.context.fill()


  pong.drawBall()
  pong.drawPaddles()
