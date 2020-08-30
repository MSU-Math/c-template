#!/usr/bin/env bash
: "${CC:=gcc -Wall -Wextra -lm -g -fsanitize=address -fsanitize=leak -fsanitize=undefined -fsanitize=null -fsanitize=bounds-strict -fstack-protector-all}"
echo $CC
$CC *.c
