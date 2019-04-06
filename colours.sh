#!/bin/bash

for i in {0..255}; do
  printf "\x1b[48;5;${i}mcolour%-5d\x1b[0m" $i
  if (((i + 1) % 8 == 0 && i != 255)); then
    printf "\n"
  fi
done
