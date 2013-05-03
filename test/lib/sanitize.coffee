sanitize = require '../../lib/lib/sanitize'

exports['no change for properly sanitized address'] = (test)->
  testaddr = 'tester@test.com'
  sanitize testaddr,(err,address)->
    test.equals address,testaddr
    return test.done()
exports['strips backslash'] = (test)->
  testaddr = 'test\\me@test.com'
  sanitize testaddr,(err,address)->
    test.equals address,'testme@test.com'
    return test.done()

