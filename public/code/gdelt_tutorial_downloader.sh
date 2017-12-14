#!/bin/sh

for i in `seq 2000 2001`
do
  curl -O 'http://gdelt.utdallas.edu/data/backfiles/'$i'.zip'
  unzip $i'.zip'
  rm $i'.zip'
  sleep 30
done