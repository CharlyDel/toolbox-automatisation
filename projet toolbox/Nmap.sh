#!/bin/bash

IP_ADDRESS=$1
OUTPUT_DIR=$2

# Exécuter le scan Nmap et sauvegarder les résultats dans un fichier XML
nmap -oX "$OUTPUT_DIR/nmap_results.xml" "$IP_ADDRESS"

# Convertir le fichier XML en XLS
xsltproc "$NMAPPDIR/nmap.xsl" "$OUTPUT_DIR/nmap_results.xml" > "$OUTPUT_DIR/nmap_results.xls"

# Convertir XLS en XLSX pour Pandas
ssconvert "$OUTPUT_DIR/nmap_results.xls" "$OUTPUT_DIR/nmap_results.xlsx"

# Nettoyer les fichiers temporaires
rm "$OUTPUT_DIR/nmap_results.xml"
rm "$OUTPUT_DIR/nmap_results.xls"
