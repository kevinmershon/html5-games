Pong.initializeGraphics = ->
  # set up a helper to draw the background
  Pong.drawBackground = ->
    Pong.context.beginPath()
    Pong.context.fillStyle = "#496e91"
    Pong.context.rect(0, 0, Pong.canvas.width, Pong.canvas.height)
    Pong.context.fill()

  # set up a helper function for drawing the ball
  Pong.drawBall = ->
    Pong.context.beginPath()
    Pong.context.arc(
      Pong.ball.position.x,
      Pong.ball.position.y,
      Pong.ball.radius,
      0,
      2 * Math.PI,
      false
    )
    Pong.context.fillStyle = "#a0c5e8"
    Pong.context.fill()

  # set up a helper function for drawing the paddles
  Pong.drawPaddles = ->
    Pong.context.beginPath()

    # left paddle
    Pong.context.rect(
      Pong.paddles.left.position.x,
      Pong.paddles.left.position.y - Pong.paddles.left.length/2,
      Pong.paddles.left.width,
      Pong.paddles.left.length
    )
    Pong.context.fillStyle = "#a0c5e8"
    Pong.context.fill()

    # right paddle
    Pong.context.rect(
      Pong.paddles.right.position.x,
      Pong.paddles.right.position.y - Pong.paddles.right.length/2,
      Pong.paddles.right.width,
      Pong.paddles.right.length
    )
    Pong.context.fillStyle = "#a0c5e8"
    Pong.context.fill()

  # set up a helper function for moving a paddle
  Pong.movePaddle = (paddle) ->
    if paddle.velocity isnt 0
      paddle.position.y += paddle.velocity

    # ensure paddle doesn't leave the screen
    if paddle.position.y - paddle.length/2 <= 0
      paddle.position.y = paddle.length/2
    if paddle.position.y + paddle.length/2 >= Pong.canvas.height
      paddle.position.y = Pong.canvas.height - paddle.length/2

    # apply drag to current velocity
    paddle.velocity *= paddle.momentum

  # set up the requestAnimationFrame helper
  requestAnimationFrame = window.requestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    window.webkitRequestAnimationFrame ||
    window.msRequestAnimationFrame
  window.requestAnimationFrame = requestAnimationFrame

  # set up a function for drawing each frame
  Pong.drawFrame = ->
    # figure out movements before drawing
    Pong.movePaddle(Pong.paddles.left)
    Pong.movePaddle(Pong.paddles.right)

    # draw the frame
    Pong.context.clearRect(
      0, 0, Pong.canvas.width, Pong.canvas.height)
    Pong.drawBackground()
    Pong.drawBall()
    Pong.drawPaddles()

    # queue the next frame to be drawn
    window.requestAnimationFrame(Pong.gameLoop)
