var config, rejectflag, simplesmtp, testEnvelope;

config = require('config').testEnvelope;

simplesmtp = require('simplesmtp');

rejectflag = false;

module.exports = testEnvelope = function(opts, cb) {
  var client;

  if (opts.index >= opts.servers.length) {
    return typeof cb === "function" ? cb("All MX servers failed", false) : void 0;
  }
  client = simplesmtp.connect(25, opts.servers[opts.index].exchange);
  client.once('idle', function() {
    return client.useEnvelope({
      from: config.fromAddress,
      to: [opts.address]
    });
  });
  client.once('error', function(err) {
    client.quit();
    opts.index++;
    if (err.name === 'RecipientError') {
      rejectflag = true;
      return typeof cb === "function" ? cb(null, false) : void 0;
    }
    if (err.name === 'SenderError') {
      return typeof cb === "function" ? cb("Sender Address rejected", false) : void 0;
    }
    return testEnvelope(opts, cb);
  });
  return client.once('message', function() {
    client.quit();
    return typeof cb === "function" ? cb(null, opts.address) : void 0;
  });
};
