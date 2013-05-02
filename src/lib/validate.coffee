check = require('validator').check

module.exports = (address, cb)->
  if check(address).isEmail()
    return cb? null,address
  return cb? "validate failed"
