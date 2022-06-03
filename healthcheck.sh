#! /bin/bash
set -e
rm -f ~/healthcheck.pdf

~/healthcheck.py

if [ -f ~/healthcheck.pdf ]; then
  exit 0
else
  exit 1
fi