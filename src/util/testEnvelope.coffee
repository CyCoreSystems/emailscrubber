config = require('config').testEnvelope
simplesmtp = require 'simplesmtp'
rejectflag = false

module.exports = testEnvelope = (opts,cb)->
  if opts.index >= opts.servers.length
    return cb? "All MX servers failed"
  client = simplesmtp.connect 25,opts.servers[opts.index].exchange
  client.once 'idle',->
    client.useEnvelope {
      from: config.fromAddress
      to: [opts.address]
    }
  client.once 'error',(err)->
    client.end()
    opts.index++
    if err.name is 'RecipientError'
      rejectflag = true
      return cb? "Server rejected recipient"
    return testEnvelope opts,cb
  client.once 'message',->
    client.end()
    return cb? null
