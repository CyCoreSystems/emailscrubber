dns = require 'dns'
testEnvelope = require '../util/testEnvelope'

module.exports = (address,cb)->
  parts = address.split '@'
  domain = parts[1]
  dns.resolveMx domain,(err,addrs)->
    if err
      return cb? "testmx failed: #{err}"
    if not addres
      return cb? "testmx failed: no MX records found"
    testEnvelope {
      address: address
      servers: addrs
      index: 0
    },(err)->
      if err
        return cb? "testmx failed: #{err}"
      return cb? null,address
