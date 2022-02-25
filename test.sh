#!/bin/zsh


# Header Test
echo '\e[1;34m'"Running Header Test"'\e[0m'
expected="200 [Oo][Kk]"
( ( node server.js & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:5000/app) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Header Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Port Test
echo '\e[1;34m'"Running Port Test"'\e[0m'
expected="200 [Oo][Kk]"
( ( node server.js --port=3000 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3000/app) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Port Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Not Found Test
echo '\e[1;34m'"Running Not Found Test"'\e[0m'
expected="404 [Nn][Oo][Tt] [Ff][Oo]"
( ( node server.js --port=2131 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:2131/app/invalid) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Not Found Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Flip Test
echo '\e[1;34m'"Running Flip Test"'\e[0m'
expected="{['\"]?flip['\"]?:['\"]?(heads|tails)['\"]?}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flip) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Flip Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Multiflip Test
echo '\e[1;34m'"Running Multiflip Test"'\e[0m'
expected="{['\"]?raw['\"]?:\[(['\"]?(heads|tails)['\"]?,){49}['\"]?(heads|tails)['\"]?\],['\"]?summary['\"]?:{['\"]?(heads|tails)['\"]?:[0-9]+(,['\"]?(heads|tails)['\"]?:[0-9]+)?}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flips/50) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Multiflip Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Multiflip Invalid Test
echo '\e[1;34m'"Running Multiflip Invalid Test"'\e[0m'
expected="{['\"]?raw['\"]?:\[['\"]?(heads|tails)['\"]?\],['\"]?summary['\"]?:{['\"]?(heads|tails)['\"]?:[0-9]}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flips/hellos) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Multiflip Invalid Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Call Heads Test
echo '\e[1;34m'"Running Call Heads Test"'\e[0m'
expected="{['\"]?call['\"]?:['\"]?heads['\"]?,['\"]?flip['\"]?:(['\"]?heads['\"]?,['\"]?result['\"]?:['\"]?win['\"]?|['\"]?tails['\"]?,['\"]?result['\"]?:['\"]?lose['\"]?)}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flip/call/heads) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Call Heads Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Call Tails Test
echo '\e[1;34m'"Running Call Tails Test"'\e[0m'
expected="{['\"]?call['\"]?:['\"]?tails['\"]?,['\"]?flip['\"]?:(['\"]?heads['\"]?,['\"]?result['\"]?:['\"]?lose['\"]?|['\"]?tails['\"]?,['\"]?result['\"]?:['\"]?win['\"]?)}"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flip/call/tails) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Call Tails Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2


# Call Invalid Test
echo '\e[1;34m'"Running Call Invalid Test"'\e[0m'
expected="404 [Nn][Oo][Tt] [Ff][Oo]"
( ( node server.js --port=3892 & sleep 2 && kill $! ) & 
( sleep 1 && result=$(curl http://localhost:3892/app/flip/call/invalid) && sleep 0.1 ;
match=$(echo "$result" | grep -E "$expected") ; 
echo "Match: $match; Result: $result; Expected: $expected\n" 
[ -n "$match" ] && echo '\e[1;32m'"Passed Call Invalid Test"'\e[0m' || ( echo '\e[1;33m'"Expected $expected" && echo '\e[1;31m'"Got: $result "'\e[0m' ) ) ) 
echo "\n\n"
sleep 2

echo "Done"