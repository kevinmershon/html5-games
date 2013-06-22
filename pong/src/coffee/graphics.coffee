Pong.initializeGraphics = ->
  # set up a helper to draw the background
  Pong.drawBackground = ->
    # fill background color
    Pong.context.beginPath()
    Pong.context.fillStyle = "black"
    Pong.context.rect(0, 0, Pong.canvas.width, Pong.canvas.height)
    Pong.context.fill()

    # draw dotted line down the center of the court
    Pong.context.beginPath()
    Pong.context.strokeStyle = "#a0c5e8"
    Pong.context.setLineDash([5, 10])
    Pong.context.moveTo(Pong.center.x, 0)
    Pong.context.lineTo(Pong.center.x, Pong.canvas.height)
    Pong.context.closePath()
    Pong.context.stroke()

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
    Pong.context.fillStyle = "white"
    Pong.context.fill()

  # set up a helper function for drawing the paddles
  Pong.drawPaddles = ->
    Pong.context.beginPath()

    # left paddle
    Pong.context.rect(
      Pong.paddles.left.position.x - Pong.paddles.left.width/2,
      Pong.paddles.left.position.y - Pong.paddles.left.length/2,
      Pong.paddles.left.width,
      Pong.paddles.left.length
    )
    Pong.context.fillStyle = "white"
    Pong.context.fill()

    # right paddle
    Pong.context.rect(
      Pong.paddles.right.position.x - Pong.paddles.right.width/2,
      Pong.paddles.right.position.y - Pong.paddles.right.length/2,
      Pong.paddles.right.width,
      Pong.paddles.right.length
    )
    Pong.context.fillStyle = "white"
    Pong.context.fill()

  # set up a helper function for moving a paddle
  Pong.movePaddle = (paddle) ->
    if paddle.velocity isnt 0
      paddle.position.y += paddle.velocity

    # ensure paddle doesn't leave the screen
    if paddle.position.y - paddle.length/2 <= 0
      paddle.position.y = paddle.length/2
      paddle.velocity = 0
    if paddle.position.y + paddle.length/2 >= Pong.canvas.height
      paddle.position.y = Pong.canvas.height - paddle.length/2
      paddle.velocity = 0

    # apply drag to current velocity
    paddle.velocity *= paddle.momentum

  # set up a helper function for moving the ball
  Pong.moveBall = (ball, left, right) ->
    ball.position.x += ball.velocity.x
    ball.position.y += ball.velocity.y

    # bounce ball against top and bottom walls
    if ball.position.y - ball.radius <= 0 or
        ball.position.y + ball.radius >= Pong.canvas.height
      ball.velocity.y = -ball.velocity.y

    if ball.position.x - ball.radius <= 0
      Pong.notify
        type: "player-two-score"
    if ball.position.x + ball.radius >= Pong.canvas.width
      Pong.notify
        type: "player-one-score"

    # bounce ball against paddles (this is much trickier!)
    #
    # start with radial distance check, for efficiency
    if ball.velocity.x < 0
      leftDistance = Math.sqrt(
        Math.pow(ball.position.x - left.position.x, 2) +
        Math.pow(ball.position.y - left.position.y, 2)
      )
      if leftDistance < left.length/2
        Pong.notify
          type: "near-left"
        # check for an actual collision
        collidedOnXaxis = (
          ball.position.x - ball.radius <=
            left.position.x + left.width/2
        )
        collidedOnYaxis = (
          # above bottom
          (ball.position.y - ball.radius <=
            left.position.y + left.length/2) and
          # below top
          (ball.position.y + ball.radius >=
            left.position.y - left.length/2)
        )
        collided = collidedOnXaxis and collidedOnYaxis
        if collided
          Pong.notify
            type: "collide-left"
          ball.velocity.x = -ball.velocity.x

    if ball.velocity.x > 0
      rightDistance = Math.sqrt(
        Math.pow(ball.position.x - right.position.x, 2) +
        Math.pow(ball.position.y - right.position.y, 2)
      )
      if rightDistance < right.length/2
        Pong.notify
          type: "near-right"
        #check for an actual collision
        collidedOnXaxis = (
          ball.position.x + ball.radius >=
            right.position.x - right.width/2
        )
        collidedOnYaxis = (
          # above bottom
          (ball.position.y - ball.radius <=
            right.position.y + right.length/2) and
          # below top
          (ball.position.y + ball.radius >=
            right.position.y - right.length/2)
        )
        collided = collidedOnXaxis and collidedOnYaxis
        if collided
          Pong.notify
            type: "collide-right"
          ball.velocity.x = -ball.velocity.x

  Pong.drawMessage = (message, color) ->
    if Pong.message
      Pong.context.fillStyle = Pong.message.color
      Pong.context.font = "bold #{Pong.message.size}px sans-serif"
      Pong.context.textAlign = "center"
      Pong.context.fillText(Pong.message.contents, Pong.center.x, Pong.center.y - 30)

  Pong.drawScores = ->
    Pong.context.fillStyle = "white"
    Pong.context.font = "bold 40px sans-serif"
    Pong.context.textAlign = "center"
    Pong.context.fillText(Pong.players.one.score, Pong.center.x - 40, 50)
    Pong.context.fillText(Pong.players.two.score, Pong.center.x + 40, 50)

  Pong.animateMessage = (message, color) ->
    Pong.message =
      color: color
      contents: message
      size: 18

  # set up the requestAnimationFrame helper
  requestAnimationFrame = window.requestAnimationFrame ||
    window.mozRequestAnimationFrame ||
    window.webkitRequestAnimationFrame ||
    window.msRequestAnimationFrame
  window.requestAnimationFrame = requestAnimationFrame

  # set up a function for drawing each frame
  Pong.drawFrame = ->
    # figure out movements before drawing
    Pong.moveBall(Pong.ball, Pong.paddles.left, Pong.paddles.right)
    Pong.movePaddle(Pong.paddles.left)
    Pong.movePaddle(Pong.paddles.right)

    # draw the frame
    Pong.context.clearRect(
      0, 0, Pong.canvas.width, Pong.canvas.height)
    Pong.drawBackground()
    Pong.drawBall()
    Pong.drawPaddles()
    Pong.drawScores()
    Pong.drawMessage()

    # queue the next frame to be drawn
    window.requestAnimationFrame(Pong.gameLoop)
