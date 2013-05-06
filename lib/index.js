var async, tests, _;

_ = require('underscore')._;

async = require('async');

tests = {
  sanitize: require('./lib/sanitize'),
  normalize: require('./lib/normalize'),
  validate: require('./lib/validate'),
  mxonly: require('./lib/mxonly'),
  testmx: require('./lib/testmx')
};

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
  checks.push(function(next) {
    return next(null, address);
  });
  if (opts.sanitize) {
    checks.push(tests.sanitize);
  }
  if (opts.normalize) {
    checks.push(tests.normalize);
  }
  if (opts.validate) {
    checks.push(tests.validate);
  }
  if (opts.mxonly) {
    checks.push(tests.mxonly);
  }
  if (opts.testmx) {
    checks.push(tests.testmx);
  }
  return async.waterfall(checks, function(err, res) {
    if (err) {
      if (typeof cb === "function") {
        cb(err, res);
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
