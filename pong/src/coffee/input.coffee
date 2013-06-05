# set up movement input handlers
Pong.initializeInput = ->
  $("body").on "keydown", (e) ->
    paddle = Pong.players.one.paddle

    switch e.which
      when 40, 74 # j (down)
        if paddle.velocity < 0
          paddle.velocity = 0
        paddle.velocity += Pong.constants.IMPULSE
        if paddle.velocity > Pong.constants.MAX_VELOCITY
          paddle.velocity = Pong.constants.MAX_VELOCITY
        paddle.momentum = 1
      when 38, 75 # k (up)
        if paddle.velocity > 0
          paddle.velocity = 0
        paddle.velocity -= Pong.constants.IMPULSE
        if paddle.velocity < -Pong.constants.MAX_VELOCITY
          paddle.velocity = -Pong.constants.MAX_VELOCITY
        paddle.momentum = 1

    Pong.players.two.paddle.velocity = -paddle.velocity
    Pong.players.two.paddle.momentum = paddle.momentum

  $("body").on "keyup", (e) ->
    paddle = Pong.players.one.paddle

    switch e.which
      when 40, 74 # j (down)
        paddle.momentum *= Pong.constants.DRAG
      when 38, 75 # k (up)
        paddle.momentum *= Pong.constants.DRAG

    Pong.players.two.paddle.velocity = -paddle.velocity
    Pong.players.two.paddle.momentum = paddle.momentum
