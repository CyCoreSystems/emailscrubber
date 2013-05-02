var async, _;

_ = require('underscore')._;

async = require('async');

module.exports = function(address, options, cb) {
  var checks, opts;

  if (options) {
    if (_.isFunction(options)) {
      cb = options;
      options = {};
    }
  }
  opts = _.extend({
    sanitize: true,
    normalize: true,
    validate: true,
    testmx: true
  }, options);
  if (!address) {
    if (typeof cb === "function") {
      cb("No address supplied to check");
    }
    return false;
  }
  checks = [];
  if (opts.sanitize) {
    checks.push(require('./lib/sanitize'));
  }
  if (opts.normalize) {
    checks.push(require('./lib/normalize'));
  }
  if (opts.validate) {
    checks.push(require('./lib/validate'));
  }
  if (opts.mxonly) {
    checks.push(require('./lib/mxonly'));
  }
  if (opts.testmx) {
    checks.push(require('./lib/testmx'));
  }
  return async.waterfall(checks, function(err, res) {
    if (err) {
      if (typeof cb === "function") {
        cb(err);
      }
      return false;
    }
    if (typeof cb === "function") {
      cb(null, res);
    }
    if (res) {
      return true;
    }
    return false;
  });
};
