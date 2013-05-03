normalize = require '../../lib/lib/normalize'

exports['no change for properly normalized address'] = (test)->
  testaddr = 'tester@test.com'
  normalize testaddr,(err,address)->
    test.equals address,testaddr
    return test.done()
exports['lowercases'] = (test)->
  testaddr = 'TestMe@Test.Com'
  normalize testaddr,(err,address)->
    test.equals address,'testme@test.com'
    return test.done()
exports['leading spaces'] = (test)->
  testaddr = '    testme@test.com'
  normalize testaddr,(err,address)->
    test.equals address,'testme@test.com'
    return test.done()
exports['trailing spaces'] = (test)->
  testaddr = 'testme@test.com   '
  normalize testaddr,(err,address)->
    test.equals address,'testme@test.com'
    return test.done()
exports['leading tab'] = (test)->
  testaddr = '	testme@test.com'
  normalize testaddr,(err,address)->
    test.equals address,'testme@test.com'
    return test.done()




