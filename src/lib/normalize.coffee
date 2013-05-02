module.exports = (address,cb)->
  try
    address = address.toLowerCase().trim()
  catch err
    return cb? err
  return cb? null,address
