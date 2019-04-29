module.exports = class ConnectionAlert
  view: __dirname

  destroy: ->
    @model.root.removeAllListeners 'change', '$connection.state'

  create: ->
    @model.set 'hideReconnect', true
    @model.root.on 'change', '$connection.state', @changed

    setTimeout (=> @model.del('hideReconnect')), 300

  changed: (state) =>
    self = this
    if state == 'disconnected'
      @model.set 'hideReconnect', true
      setTimeout (->
        self.model.del 'hideReconnect'
      ), 1000

  reconnect: ->
    model = @model
    # Hide the reconnect link for a second after clicking it
    model.set 'hideReconnect', true
    setTimeout (->
      model.del 'hideReconnect'
    ), 1000
    model.reconnect()

  reload: ->
    window.location.reload()

  sentenceCase: (text) ->
    text and text.charAt(0).toUpperCase() + text.slice(1)

module.exports = ConnectionAlert