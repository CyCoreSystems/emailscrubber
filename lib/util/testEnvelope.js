var config, rejectflag, simplesmtp, testEnvelope;

config = require('config').testEnvelope;

simplesmtp = require('simplesmtp');

rejectflag = false;

module.exports = testEnvelope = function(opts, cb) {
  var client;

  if (opts.index >= opts.servers.length) {
    return typeof cb === "function" ? cb("All MX servers failed") : void 0;
  }
  client = simplesmtp.connect(25, opts.servers[opts.index].exchange);
  client.once('idle', function() {
    return client.useEnvelope({
      from: config.fromAddress,
      to: [opts.address]
    });
  });
  client.once('error', function(err) {
    client.end();
    opts.index++;
    if (err.name === 'RecipientError') {
      rejectflag = true;
      return typeof cb === "function" ? cb("Server rejected recipient") : void 0;
    }
    return testEnvelope(opts, cb);
  });
  return client.once('message', function() {
    client.end();
    return typeof cb === "function" ? cb(null) : void 0;
  });
};
