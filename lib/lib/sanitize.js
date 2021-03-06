module.exports = function(address, cb) {
  var err;

  try {
    address = address.replace(/[^\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~\.\@]/, '');
  } catch (_error) {
    err = _error;
    return typeof cb === "function" ? cb(err) : void 0;
  }
  return typeof cb === "function" ? cb(null, address) : void 0;
};
