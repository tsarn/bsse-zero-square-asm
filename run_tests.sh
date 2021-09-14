#!/bin/bash

set -ex

cd "$(dirname "$0")"

for i in {01..20}; do
    ./main < tests/$i > tests/$i.out
    diff tests/$i.a tests/$i.out
done
