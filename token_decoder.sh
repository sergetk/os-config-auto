#!/bin/bash
##
##openssl enc -aes-256-cbc -salt -in gittokensource.txt -out gt.enc -pass file:pass.txt -iter 1000
openssl enc -d -aes-256-cbc -in gt.enc -out token.txt -pass file:pass.txt -iter 1000 
