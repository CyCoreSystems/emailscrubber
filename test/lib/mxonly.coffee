mxonly = require '../../lib/lib/mxonly'

exports['works if correct'] = (test)->
  testaddr = 'ulexus@gmail.com'
  mxonly testaddr,(err,address)->
    test.equals address,testaddr
    return test.done()
exports['no DNS'] = (test)->
  testaddr = 'test@asldasdalksjdajklsdkliosiasdis.com'
  mxonly testaddr,(err,address)->
    test.equal false,address
    return test.done()
exports['no mx records'] = (test)->
  testaddr = 'test@cycoresys.net'
  mxonly testaddr,(err,address)->
    test.equal false,address
    return test.done()
