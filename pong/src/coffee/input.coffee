# set up movement input handlers
pong.initializeInput = ->
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
