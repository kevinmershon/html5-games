Pong.test = (->
  @deferred = $.Deferred()

  @runTest = (t) ->
    Pong.reset()
    Pong.listeners.push
      type: "end-test"
      notify: (event) =>
        t.tearDown()
        Pong.reset()
        @deferred.resolve()
    Pong.notify
      type: "begin-test"
    t.setUp()
    t.call()

  @runAllTests = ->
    # queue up all tests in the deferred handler
    for t in Pong.test.tests then do (t) =>
      @deferred.then Pong.test.runTest(t)

  @tests = []

  this
)()

# Test 1
#
# Bounce back and forth between paddles for 2 bounces each
Pong.test.tests.push (->
  @hitCount = 0
  @checkCollisions = (event) =>
    @hitCount++
    console.log "#{@hitCount} / 4"
    if @hitCount is 4
      Pong.notify
        type: "end-test"
  @leftListener =
    type: "collide-left"
    notify: (event) => @checkCollisions(event)
  @rightListener =
    type: "collide-right"
    notify: (event) => @checkCollisions(event)

  @setUp = =>
    @hitCount = 0
    Pong.listeners.push(@leftListener)
    Pong.listeners.push(@rightListener)
  @call = =>
    Pong.animateText("2 bounces per paddle", "red")
    # reset the ball
    Pong.ball.velocity =
      x: 5
      y: 0
  @tearDown = =>
    Pong.listeners = _.without(
      Pong.listeners, @leftListener, @rightListener
    )
    console.log "done!"

  this
)()
