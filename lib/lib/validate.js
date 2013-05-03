var check;

check = require('validator').check;

module.exports = function(address, cb) {
  var err;

  try {
    check(address).isEmail();
  } catch (_error) {
    err = _error;
    return typeof cb === "function" ? cb(err, false) : void 0;
  }
  return typeof cb === "function" ? cb(null, address) : void 0;
};
