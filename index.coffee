module.exports = class ConnectionAlert
  view: __dirname

  destroy: ->
    @model.root.removeAllListeners 'change', '$connection.state'

  create: ->
    @model.root.on 'change', '$connection.state', @changed
    setTimeout (=> @model.set('showReconnect', 1)), 3000

  changed: (state) =>
    if state == 'disconnected'
      @model.del 'showReconnect'
      setTimeout (=> @model.set 'showReconnect', 1), 3000

  reconnect: ->
    # Hide the reconnect link for a second after clicking it
    @model.del 'showReconnect'
    setTimeout (=> @model.set 'showReconnect', 1), 1000
    @model.reconnect()

  reload: ->
    window.location.reload()

  sentenceCase: (text) ->
    text and text.charAt(0).toUpperCase() + text.slice(1)

module.exports = ConnectionAlert