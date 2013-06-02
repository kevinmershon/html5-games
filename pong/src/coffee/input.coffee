# set up movement input handlers
Pong.initializeInput = ->
  $("body").on "keydown", (e) ->
    paddle = Pong.players.one.paddle

    switch e.which
      when 40, 74 # j (down)
        paddle.velocity += Pong.constants.IMPULSE
        if paddle.velocity > Pong.constants.MAX_VELOCITY
          paddle.velocity = Pong.constants.MAX_VELOCITY
        paddle.momentum = 1
        console.log paddle.velocity
      when 38, 75 # k (up)
        paddle.velocity -= Pong.constants.IMPULSE
        if paddle.velocity < -Pong.constants.MAX_VELOCITY
          paddle.velocity = -Pong.constants.MAX_VELOCITY
        paddle.momentum = 1
        console.log paddle.velocity

  $("body").on "keyup", (e) ->
    paddle = Pong.players.one.paddle

    switch e.which
      when 40, 74 # j (down)
        paddle.momentum *= Pong.constants.DRAG
        console.log paddle.velocity
      when 38, 75 # k (up)
        paddle.momentum *= Pong.constants.DRAG
        console.log paddle.velocity
