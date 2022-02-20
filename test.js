const { spawn }  = require("child_process");


function testCommand(testName, command, expected) {
  console.log(testName)
  const line = "----------------------------------"
  console.log(line)
  spawn(command, (error, stdout, stderr) => {
    if (error) {
      console.log(`error: ${error.message}`);
      console.log(line)
      return;
    }
    if (stderr) {
      console.log(`stderr: ${stderr}`);
      console.log(line)
      return;
    }
    if (stdout === expected) {
      console.log(`Received Correct Response:\n${stdout}`)
    } else {
      console.log(`Expected Response:\n ${expected}\nReceived:\n${stdout}`)
    }
    console.log(line)
  })
}

console.log("Start here")

spawn("node server.js", (error, stdout, stderr) => {
  console.log("Is this working?")
  if (error) {
      console.log(`error: ${error.message}`);
      return;
  }
  if (stderr) {
      console.log(`stderr: ${stderr}`);
      return;
  }
  console.log(`Output: ${stdout}`)
  console.log("Running Tests")
  testCommand("Testing Response", "curl http://localhost:5000/app/", "200 OK")
  testCommand("Testing Header", "curl -I http://localhost:5000/app/", 
  `i=HTTP/1.1 200 OK
  X-Powered-By: Express
  Content-Type: text/plain
  Date: Tue, 15 Feb 2022 18:02:32 GMT
  Connection: keep-alive
  Keep-Alive: timeout=5
  `
  )
  testCommand("Testing Flip", "curl http://localhost:5000/app/flip/", `{"flip":"tails"}`)
  testCommand("Testing Flip", "curl http://localhost:5000/app/flip/", `{"flip":"tails"}`)

  // console.log(`stdout: ${stdout}`);
});