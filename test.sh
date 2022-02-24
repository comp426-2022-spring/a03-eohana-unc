#!/bin/zsh


# Header Test
echo "Running Header Test"
expected="200 [Oo][Kk]"
( ( node server.js & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:5000/app) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Header Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) )

sleep 2


# Port Test
echo "Running Port Test"
expected="200 [Oo][Kk]"
( ( node server.js --port=3000 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3000/app) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Port Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) )

sleep 2


# Not Found Test
echo "Running Not Found Test"
expected="404 [Nn][Oo][Tt] [Ff][Oo]"
( ( node server.js --port=2131 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:2131/app/invalid) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Not Found Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) )

sleep 2


# Flip Test
echo "Running Flip Test"
expected="{['\"]flip['\"]:['\"](heads|tails)['\"]}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flip) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Flip Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) )

sleep 2


# Multiflip Test
echo "Running Multiflip Test"
expected="{['\"]raw['\"]:\[(['\"](heads|tails)['\"],){49}['\"](heads|tails)['\"]\],['\"]summary['\"]:{['\"](heads|tails)['\"]:[0-9]+(,['\"](heads|tails)['\"]:[0-9]+)?}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flips/50) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Multiflip Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) )

sleep 2


# Multiflip Invalid Test
echo "Running Multiflip Invalid Test"
expected="{['\"]raw['\"]:\[['\"](heads|tails)['\"]\],['\"]summary['\"]:{['\"](heads|tails)['\"]:[0-9]}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flips/hellos) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Multiflip Invalid Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) )

sleep 2

echo "Done"