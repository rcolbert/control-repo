#!/bin/bash
#
HOST="mantech.puppetagent1.com"
CA="mantechca"
O="Mantech"
OU="GL"
C="US"
L="Herndon"
ST="VA"

#create ca
openssl req -x509 -sha384 -nodes -days 3650 -newkey rsa:2048 -keyout $CA.key -out ./$CA.crt \
-subj "/CN=ca/O=$O/OU=$OU/L=$L/ST=$ST/C=$C" 
#remove passkey
openssl rsa -in $CA.key -out $CA.key 
# create csr
openssl req -new -newkey rsa:2048 -sha384 -nodes -keyout $HOST.key -out $HOST.csr \
-subj "/CN=ca/O=$O/OU=$OU/L=$L/ST=$ST/C=$C" -create_serial
#sign cert
#openssl ca -config ca.conf -out $HOST.pem.crt -infiles $HOST.pem -v
openssl ca -cert $CA.crt -keyfile $CA.key -out $HOST.crt -infiles $HOST.csr \
#-subj "/CN=ca/O=$O/OU=$OU/L=$L/ST=$ST/C=$C" 
#-create_serial 
