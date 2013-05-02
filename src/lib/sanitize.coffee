module.exports = (address,cb)->
  try
    address = address.replace /[^\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~\.\@]/,''
  catch err
    return cb? err
  return cb? null,address
