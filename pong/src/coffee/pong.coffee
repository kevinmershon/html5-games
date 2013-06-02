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

  # set up the main game loop
  pong.gameLoop = ->
    pong.context.clearRect(
      0, 0, pong.canvas.width, pong.canvas.height)
    pong.drawBackground()
    pong.drawBall()
    if pong.players.one.velocity isnt 0
      pong.movePaddle(pong.players.one)
      pong.players.one.velocity *= pong.players.one.momentum
    pong.drawPaddles()

    window.requestAnimationFrame(pong.gameLoop)

  # kick off the game loop
  pong.gameLoop()

  # set up movement input handlers
  $("body").on "keydown", (e) ->
    switch e.which
      when 40, 74 # j (down)
        pong.players.one.velocity += pong.constants.IMPULSE
        if pong.players.one.velocity > pong.constants.MAX_VELOCITY
          pong.players.one.velocity = pong.constants.MAX_VELOCITY
        pong.players.one.momentum = 1
        console.log pong.players.one.velocity
      when 38, 75 # k (up)
        pong.players.one.velocity -= pong.constants.IMPULSE
        if pong.players.one.velocity < -pong.constants.MAX_VELOCITY
          pong.players.one.velocity = -pong.constants.MAX_VELOCITY
        pong.players.one.momentum = 1
        console.log pong.players.one.velocity
  $("body").on "keyup", (e) ->
    switch e.which
      when 40, 74 # j (down)
        pong.players.one.momentum *= pong.constants.DRAG
        console.log pong.players.one.velocity
      when 38, 75 # k (up)
        pong.players.one.momentum *= pong.constants.DRAG
        console.log pong.players.one.velocity
