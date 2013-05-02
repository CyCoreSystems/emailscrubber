config = require 'config'.testEnvelope
simplesmtp = require 'simplesmtp'

module.exports = testEnvelope = (opts,cb)->
  if opts.index >= opts.servers.length
    return cb? "All MX servers failed"
  client = simplesmtp.connect 25,opts.servers[opts.index]
  client.once 'idle',->
    client.useEnvelope {
      from: config.fromAddress,
      to: opts.address
    }
  client.once 'rcptFailed',(addr)->
    client.end()
    return cb? "Address rejected by server"
  client.once 'error',(err)->
    console.log "Error encountered contacting server:",err
    opts.index++
    client.end()
    return testEnvelope opts,cb
  client.once 'message',->
    client.end()
    return cb? null
