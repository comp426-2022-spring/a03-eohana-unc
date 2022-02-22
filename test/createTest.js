#!/usr/local/bin/node

const fs = require('fs')

// Open the JSON file

function writeBashTest(test) {
  let result = `\n# ${test["testname"]}\n`
  result += `echo "Running ${test["testname"]}"\n`
  result += `expected="${test["expected"]}"\n`
  result += `( ( node server.js ${configurePortArg(test["server-port"])}& sleep ${test["server-timer"]} && kill $! ) & \n`
  result += `( sleep 1 && result=$(curl ${test["curl-flags"]}http://localhost:${test["client-port"]}${test["endpoint"]}) && sleep 0.1 ;\n`
  result += `match=$(echo "$result" | grep -E "$expected") ; \n`
  result += `echo "Match: $match; Result: $result; Expected: $expected\\n" \n`
  result += `[ -n "$match" ] && echo "Passed ${test["testname"]}" || echo "Expected $expected \\nGot: $result ") )\n\n`
  result += `sleep ${test["server-timer"]}\n\n`
  return result
}

function configurePortArg(port){
  if (port.length > 0){
    return `--port=${port} `
  } else {
    return ""
  }
}
const f = fs.readFileSync("./test.json")
const tests = JSON.parse(f)

let content = "#!/bin/zsh\n\n"

// console.log(tests[0])
for (let test of tests) {
  content += writeBashTest(test)
  // console.log(test)
}
content += `echo "Done"`
// console.log(content)

fs.writeFile('../test.sh', content, err => {
  if (err) {
    console.error(err)
    return
  }
  //file written successfully
})