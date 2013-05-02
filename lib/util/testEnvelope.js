var config, simplesmtp, testEnvelope;

config = require('config').testEnvelope;

simplesmtp = require('simplesmtp');

module.exports = testEnvelope = function(opts, cb) {
  var client;

  if (opts.index >= opts.servers.length) {
    return typeof cb === "function" ? cb("All MX servers failed") : void 0;
  }
  client = simplesmtp.connect(25, opts.servers[opts.index]);
  client.once('idle', function() {
    return client.useEnvelope({
      from: config.fromAddress,
      to: opts.address
    });
  });
  client.once('rcptFailed', function(addr) {
    client.end();
    return typeof cb === "function" ? cb("Address rejected by server") : void 0;
  });
  client.once('error', function(err) {
    console.log("Error encountered contacting server:", err);
    opts.index++;
    client.end();
    return testEnvelope(opts, cb);
  });
  return client.once('message', function() {
    client.end();
    return typeof cb === "function" ? cb(null) : void 0;
  });
};
