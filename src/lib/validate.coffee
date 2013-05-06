check = require('validator').check

module.exports = (address,cb)->
  try
    check(address).isEmail()
  catch err
    return cb? err,false
  return cb? null,address
