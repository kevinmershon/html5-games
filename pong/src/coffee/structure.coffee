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
    right:
      length: 100
      momentum: 0
      position:
        x: Pong.canvas.width - 10
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

  Pong.listeners = []

  Pong.notify = (event) ->
    for listener in Pong.listeners then do (listener) =>
      if event.type is listener.type
        listener.notify(event)

  Pong.listeners.push
    type: "reset"
    notify: ->
      console.log "reset!"
  Pong.listeners.push
    type: "collide-left"
    notify: ->
      console.log "collide left!"
  Pong.listeners.push
    type: "collide-right"
    notify: ->
      console.log "collide right!"
