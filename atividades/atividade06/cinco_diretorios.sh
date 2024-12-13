#!/bin/bash

mkdir -p cinco

for i in {1..5}; do
  subdir="cinco/dir$i"
  mkdir -p "$subdir"

  for j in {1..4}; do
    arquivo="$subdir/arq$j.txt"
    seq -s '\n' $j > "$arquivo"
  done
done
