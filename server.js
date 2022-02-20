const express = require('express')
const app = express()
const args = require("minimist")(process.argv)

const port = args["port"] || 5000

app.get('/app', (req, res) => {
  res.statusCode = 200
  res.statusMessage = "OK"
  res.writeHead(res.statusCode, {"Content-Type": "text/plain"})
  res.end(res.statusCode + " " + res.statusMessage)
})



app.use((req, res) => {
  res.status(404).send('404 NOT FOUND\n')
})

app.listen(port, () => {
  console.log('App listening on port %PORT%'.replace('%PORT%',port))
})