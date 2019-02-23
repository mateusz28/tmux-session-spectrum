#!/bin/bash

for i in {0..255}; do
  if (((i + 1) % 8 == 0)); then
    width=0
  else
    width=5
  fi
  printf "\x1b[38;5;${i}mcolour%-${width}d\x1b[0m" $i
  if (((i + 1) % 8 == 0 && i != 255)); then
    printf "\n"
  fi
done
