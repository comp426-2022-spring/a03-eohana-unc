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


# Port Test
echo "Running Port Test"
expected="200 [Oo][Kk]"
( ( node server.js --port=3000 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3000/app) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo "Passed Port Test" || echo "Expected $expected \nGot: $result ") )

sleep 2


# Not Found Test
echo "Running Not Found Test"
expected="404 [Nn][Oo][Tt] [Ff][Oo]"
( ( node server.js --port=2131 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:2131/app/invalid) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo "Passed Not Found Test" || echo "Expected $expected \nGot: $result ") )

sleep 2


# Flip Test
echo "Running Flip Test"
expected="404 [Nn][Oo][Tt] [Ff][Oo]"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flip) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo "Passed Flip Test" || echo "Expected $expected \nGot: $result ") )

sleep 2

echo "Done"