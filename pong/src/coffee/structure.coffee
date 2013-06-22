Pong.initializeStructure = ->
  Pong.center =
    x: Pong.canvas.width / 2
    y: Pong.canvas.height / 2

  # start the ball in the center of the screen
  Pong.ball =
    position:
      x: Pong.center.x
      y: Pong.center.y
    velocity:
      x: 0
      y: 0
    radius: 10
    reset: ->
      Pong.ball.position =
        x: Pong.center.x
        y: Pong.center.y
      Pong.ball.velocity =
        x: 0
        y: 0

  # set up the paddles
  Pong.paddles =
    left:
      length: 100
      momentum: 0
      position:
        x: 10
        y: Pong.center.y
      velocity: 0.0
      width: 10
      reset: ->
        Pong.paddles.left.momentum = 0
        Pong.paddles.left.velocity = 0
        Pong.paddles.left.length = 100
        Pong.paddles.left.position =
          x: 10
          y: Pong.center.y
    right:
      length: 100
      momentum: 0
      position:
        x: Pong.canvas.width - 10
        y: Pong.center.y
      velocity: 0.0
      width: 10
      reset: ->
        Pong.paddles.right.momentum = 0
        Pong.paddles.right.velocity = 0
        Pong.paddles.right.length = 100
        Pong.paddles.right.position =
          x: Pong.canvas.width - 10
          y: Pong.center.y

  # set up player state
  Pong.players =
    one:
      paddle: Pong.paddles.left
      score: 0
    two:
      paddle: Pong.paddles.right
      score: 0

  # set up crude event listener/notification
  Pong.listeners = []
  Pong.notify = (event) ->
    for listener in Pong.listeners then do (listener) =>
      if event.type is listener.type
        listener.notify(event)

  # add debugging listeners
  Pong.listeners.push
    type: "reset"
    notify: ->
      console.log "reset!"
  Pong.listeners.push
    type: "collide-left"
    notify: ->
      Pong.paddles.left.length = Math.max(
        20,
        Pong.paddles.left.length - 5
      )
      console.log "collide left!"
  Pong.listeners.push
    type: "collide-right"
    notify: ->
      Pong.paddles.right.length = Math.max(
        20,
        Pong.paddles.right.length - 5
      )
      console.log "collide right!"
  Pong.listeners.push
    type: "player-one-score"
    notify: ->
      Pong.players.one.score++
      Pong.animateMessage("Player one scores! #{Pong.players.one.score}", "red")
      Pong.reset()
  Pong.listeners.push
    type: "player-two-score"
    notify: ->
      Pong.players.two.score++
      Pong.animateMessage("Player two scores! #{Pong.players.two.score}", "red")
      Pong.reset()
  Pong.listeners.push
    type: "play-start"
    notify: ->
      Pong.message = null

  # set up a global reset function
  Pong.reset = ->
    Pong.ball.reset()
    # Pong.paddles.left.reset()
    # Pong.paddles.right.reset()

    Pong.notify
      type: "reset"

