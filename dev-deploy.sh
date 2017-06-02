#!/bin/bash


PRODLINE='baseurl="http:\/\/cmc-demo.com.s3-website-us-east-1.amazonaws.com\/"'

cp config.toml config.toml.original
sed "1s/.*/$PRODLINE/" config.toml > config.toml.replace
cp config.toml.replace config.toml

hugo --buildDrafts

cp public/about/index.html public/index.html
aws s3 sync public/ s3://cmc-demo.com  --delete --exclude ".DS_store"

cp config.toml.original config.toml
rm config.toml.original
rm config.toml.replace