dns = require 'dns'
testEnvelope = require '../util/testEnvelope'

module.exports = (address,cb)->
  parts = address.split '@'
  domain = parts[1]
  dns.resolveMx domain,(err,addrs)->
    if err
      return cb? "testmx failed: #{err}",false
    if not addrs
      return cb? "testmx failed: no MX records found",false
    testEnvelope {
      address: address
      servers: addrs
      index: 0
    },(err,address)->
      # Should only have an error if the test was inconclusive
      if err
        return cb? "testmx failed: #{err}",false
      return cb? null,address
