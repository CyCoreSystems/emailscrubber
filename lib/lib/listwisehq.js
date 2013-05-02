var dns, testEnvelope;

dns = require('dns');

testEnvelope = require('../util/testEnvelope');

module.exports = function(address, cb) {
  var domain, parts;

  parts = address.split('@');
  domain = parts[1];
  return typeof cb === "function" ? cb(null, address) : void 0;
};
