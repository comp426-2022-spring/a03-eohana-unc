#!/bin/zsh


# Header Test
echo "Running Header Test"
expected="200 [Oo][Kk]"
( ( node server.js & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:5000/app) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo "Passed Header Test" || echo "Expected $expected \nGot: $result ") )

sleep 2

echo "Done"