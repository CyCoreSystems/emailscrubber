dns = require 'dns'
testEnvelope = require '../util/testEnvelope'

module.exports = (address,cb)->
  parts = address.split '@'
  domain = parts[1]
  # Not yet implemented
  return cb? null,address
