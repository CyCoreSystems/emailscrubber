scrubber = require '../index'

exports['default-valid'] = (test)->
  testaddr = 'ulexus@gmail.com'
  scrubber testaddr,(err,address)->
    test.equals testaddr,address
    return test.done()
exports['no DNS'] = (test)->
  testaddr = 'test@asldasdalksjdajklsdkliosiasdis.com'
  scrubber testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no mx records'] = (test)->
  testaddr = 'test@cycoresys.net'
  scrubber testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
exports['no user'] = (test)->
  testaddr = 'bozo@cycoresys.com'
  scrubber testaddr,(err,address)->
    test.strictEqual false,address
    return test.done()
