_ = require('underscore')._
async = require 'async'

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
  if opts.sanitize
    checks.push require './lib/sanitize'
  if opts.normalize
    checks.push require './lib/normalize'
  if opts.validate
    checks.push require './lib/validate'
  if opts.mxonly
    checks.push require './lib/mxonly'
  if opts.testmx
    checks.push require './lib/testmx'
  async.waterfall checks,(err, res)->
    if err
      cb? err
      return false
    cb? null,res
    if res
      return true
    return false
