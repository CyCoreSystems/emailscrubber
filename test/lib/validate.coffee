validate = require '../../lib/lib/validate'

exports['no change if correct'] = (test)->
  testaddr = 'tester@test.com'
  validate testaddr,(err,address)->
    test.equals address,testaddr
    return test.done()
exports['no domain'] = (test)->
  testaddr = 'testme@'
  validate testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no user'] = (test)->
  testaddr = '@test.com'
  validate testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no at'] = (test)->
  testaddr = 'testme.test.com'
  validate testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no tld'] = (test)->
  testaddr = 'testme@test'
  validate testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
