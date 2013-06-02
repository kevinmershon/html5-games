pong.initializeGraphics = ->
  # set up a helper to draw the background
  pong.drawBackground = ->
    pong.context.beginPath()
    pong.context.fillStyle = "#496e91"
    pong.context.rect(0, 0, pong.canvas.width, pong.canvas.height)
    pong.context.fill()

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
    pong.context.fillStyle = "#a0c5e8"
    pong.context.fill()

  # set up a helper function for drawing the paddles
  pong.drawPaddles = ->
    pong.context.beginPath()

    # left paddle
    pong.context.rect(
      pong.paddles.left.position.x,
      pong.paddles.left.position.y - pong.paddles.left.length/2,
      pong.paddles.left.width,
      pong.paddles.left.length
    )
    pong.context.fillStyle = "#a0c5e8"
    pong.context.fill()

    # right paddle
    pong.context.rect(
      pong.paddles.right.position.x,
      pong.paddles.right.position.y - pong.paddles.right.length/2,
      pong.paddles.right.width,
      pong.paddles.right.length
    )
    pong.context.fillStyle = "#a0c5e8"
    pong.context.fill()

  # set up a helper function for moving a paddle
  pong.movePaddle = (player) ->
    paddle = player.paddle
    if player.velocity isnt 0
      paddle.position.y += player.velocity

    if paddle.position.y - paddle.length/2 <= 0
      paddle.position.y = paddle.length/2
    if paddle.position.y + paddle.length/2 >= pong.canvas.height
      paddle.position.y = pong.canvas.height - paddle.length/2

  # set up the requestAnimationFrame helper
  requestAnimationFrame = window.requestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    window.webkitRequestAnimationFrame ||
    window.msRequestAnimationFrame
  window.requestAnimationFrame = requestAnimationFrame

  # set up a function for drawing each frame
  pong.drawFrame = ->
    pong.context.clearRect(
      0, 0, pong.canvas.width, pong.canvas.height)
    pong.drawBackground()
    pong.drawBall()
    if pong.players.one.velocity isnt 0
      pong.movePaddle(pong.players.one)
      pong.players.one.velocity *= pong.players.one.momentum
    pong.drawPaddles()

    window.requestAnimationFrame(pong.gameLoop)
