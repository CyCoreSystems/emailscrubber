testmx = require '../../lib/lib/testmx'

exports['works if correct'] = (test)->
  testaddr = 'ulexus@gmail.com'
  testmx testaddr,(err,address)->
    test.equals testaddr,address
    return test.done()
exports['no DNS'] = (test)->
  testaddr = 'test@asldasdalksjdajklsdkliosiasdis.com'
  testmx testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no mx records'] = (test)->
  testaddr = 'test@cycoresys.net'
  testmx testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no user'] = (test)->
  testaddr = 'bozo@cycoresys.com'
  testmx testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
