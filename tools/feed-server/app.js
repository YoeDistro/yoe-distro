// nodejs script to start a http server with the feed from this directory
// default is port 4000

var express = require('express')

var app = express()

app.use('/', express.static(__dirname + '/../../build/tmp-angstrom-glibc/deploy/ipk/'))
app.use('/', express.directory(__dirname +'/../../build/tmp-angstrom-glibc/deploy/ipk/'))

console.log("feed server started on port 4000")
app.listen(4000)


