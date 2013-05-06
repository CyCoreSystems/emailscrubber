config = require('config').testEnvelope
simplesmtp = require 'simplesmtp'
rejectflag = false

module.exports = testEnvelope = (opts,cb)->
  if opts.index >= opts.servers.length
    return cb? "All MX servers failed",false
  client = simplesmtp.connect 25,opts.servers[opts.index].exchange
  client.once 'idle',->
    client.useEnvelope {
      from: config.fromAddress
      to: [opts.address]
    }
  client.once 'error',(err)->
    client.quit()
    opts.index++
    if err.name is 'RecipientError'
      rejectflag = true
      return cb? null,false
    if err.name is 'SenderError'
      return cb? "Sender Address rejected",false
    return testEnvelope opts,cb
  client.once 'message',->
    client.quit()
    return cb? null,opts.address
