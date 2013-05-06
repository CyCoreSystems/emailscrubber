_ = require('underscore')._
async = require 'async'
tests =
  sanitize: require './lib/sanitize'
  normalize: require './lib/normalize'
  validate: require './lib/validate'
  mxonly: require './lib/mxonly'
  testmx: require './lib/testmx'

module.exports = (address, options, cb) ->
  if options
    if _.isFunction(options)
      cb = options
      options = {}
  opts = _.extend {
    sanitize: true,
    normalize: true,
    validate: true,
    testmx: true
  },options

  if not address
    cb? "No address supplied to check"
    return false
  
  checks = []
  # Add dummy function to allow the rest
  # of the calls have the same signature
  checks.push (next)->
    return next null,address
  if opts.sanitize
    checks.push tests.sanitize
  if opts.normalize
    checks.push tests.normalize
  if opts.validate
    checks.push tests.validate
  if opts.mxonly
    checks.push tests.mxonly
  if opts.testmx
    checks.push tests.testmx
  async.waterfall checks,(err,res)->
    if err
      cb? err,res
      return false
    cb? null,res
    if res
      return true
    return false
