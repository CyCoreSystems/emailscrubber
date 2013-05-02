var check;

check = require('validator').check;

module.exports = function(address, cb) {
  if (check(address).isEmail()) {
    return typeof cb === "function" ? cb(null, address) : void 0;
  }
  return typeof cb === "function" ? cb("validate failed") : void 0;
};
