var dns, testEnvelope;

dns = require('dns');

testEnvelope = require('../util/testEnvelope');

module.exports = function(address, cb) {
  var domain, parts;

  parts = address.split('@');
  domain = parts[1];
  return dns.resolveMx(domain, function(err, addrs) {
    if (err) {
      return typeof cb === "function" ? cb("testmx failed: " + err, false) : void 0;
    }
    if (!addrs) {
      return typeof cb === "function" ? cb("testmx failed: no MX records found", false) : void 0;
    }
    return testEnvelope({
      address: address,
      servers: addrs,
      index: 0
    }, function(err) {
      if (err) {
        return typeof cb === "function" ? cb("testmx failed: " + err, false) : void 0;
      }
      return typeof cb === "function" ? cb(null, address) : void 0;
    });
  });
};
