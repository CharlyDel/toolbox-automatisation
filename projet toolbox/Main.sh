#!/bin/bash

# Accepter les arguments depuis la ligne de commande
IP_ADDRESS=$1
OUTPUT_DIR=$2
TOOL=$3

# Créer le dossier de sortie s'il n'existe pas
mkdir -p "$OUTPUT_DIR"

# Définir NMAPPDIR pour éviter l'avertissement
export NMAPPDIR=$(pwd)

# Exécuter l'outil sélectionné avec les paramètres appropriés
if [ "$TOOL" == "Nikto" ]; then
    echo "Running Nikto on $IP_ADDRESS, output to $OUTPUT_DIR"
    cd /root/nikto/program
    sudo perl nikto.pl -h "$IP_ADDRESS" -o "$OUTPUT_DIR/nikto_output.txt"
elif [ "$TOOL" == "Nmap" ]; then
    echo "Running Nmap on $IP_ADDRESS, output to $OUTPUT_DIR"
    ./Nmap.sh "$IP_ADDRESS" "$OUTPUT_DIR"
elif [ "$TOOL" == "Both" ]; then
    echo "Running Nikto and Nmap on $IP_ADDRESS, output to $OUTPUT_DIR"
    cd /root/nikto/program
    sudo perl nikto.pl -h "$IP_ADDRESS" -o "$OUTPUT_DIR/nikto_output.txt"
    ./Nmap.sh "$IP_ADDRESS" "$OUTPUT_DIR"
else
    echo "Invalid tool specified. Please choose 'Nikto', 'Nmap', or 'Both'."
    exit 1
fi

# Convertir le fichier XLS en Markdown et en PDF
python3 << END
import pandas as pd

# Lire les résultats du scan Nmap depuis le fichier XLS
df = pd.read_excel("$OUTPUT_DIR/nmap_results.xlsx")

# Convertir le dataframe en markdown
md_content = df.to_markdown(index=False)

# Sauvegarder le contenu markdown dans un fichier temporaire
md_file = "$OUTPUT_DIR/nmap_results.md"
with open(md_file, "w") as file:
    file.write(md_content)

# Générer le contenu LaTeX pour Pandoc
latex_content = f"""
# Nmap Scan Report

## Open Ports

{md_content}
"""

# Sauvegarder le contenu LaTeX dans un fichier temporaire
latex_file = "$OUTPUT_DIR/report.md"
with open(latex_file, "w") as file:
    file.write(latex_content)
END

# Convertir le fichier Markdown en PDF avec Pandoc
if [ -f "$OUTPUT_DIR/report.md" ]; then
    pandoc "$OUTPUT_DIR/report.md" -o "$OUTPUT_DIR/report.pdf"
    if [ $? -eq 0 ]; then
        echo "PDF created successfully."
        # Supprimer les fichiers temporaires
        rm "$OUTPUT_DIR/report.md"
        rm "$OUTPUT_DIR/nmap_results.md"
    else
        echo "Error during PDF creation."
    fi
else
    echo "Error: Markdown file not created."
fi

echo "Script completed. Report saved to $OUTPUT_DIR/report.pdf"
