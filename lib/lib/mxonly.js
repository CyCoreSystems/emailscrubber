var dns;

dns = require('dns');

module.exports = function(address, cb) {
  var domain, parts;

  parts = address.split('@');
  domain = parts[1];
  return dns.resolveMx(domain, function(err, addrs) {
    if (err) {
      return typeof cb === "function" ? cb("mx failed: " + err, false) : void 0;
    }
    if (!addrs) {
      return typeof cb === "function" ? cb("mx failed: no MX records found", false) : void 0;
    }
    return typeof cb === "function" ? cb(null, address) : void 0;
  });
};
