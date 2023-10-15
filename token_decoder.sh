#!/bin/bash
##

openssl enc -d -aes-256-cbc -in gt.enc -out token.txt -pass file:pass.txt -iter 1000 
