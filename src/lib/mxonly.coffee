dns = require 'dns'

module.exports = (address,cb)->
  parts = address.split '@'
  domain = parts[1]
  dns.resolveMx domain,(err, addrs)->
    if err
      return cb? "mx failed: #{err}",false
    if not addrs
      return cb? "mx failed: no MX records found",false
    return cb? null,address
