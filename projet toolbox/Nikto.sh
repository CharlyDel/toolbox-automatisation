#!/bin/bash

IP_ADDRESS=$1
OUTPUT_DIR=$2

# Exécuter Nikto et sauvegarder les résultats
cd /root/nikto/program
sudo perl nikto.pl -h "$IP_ADDRESS" -o "$OUTPUT_DIR/nikto_output.txt"
