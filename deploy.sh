#!/bin/bash

hugo
cp public/about/index.html public/index.html
aws s3 sync public/ s3://chrismeserole.com  --delete --exclude ".DS_store"