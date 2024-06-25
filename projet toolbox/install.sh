#!/bin/bash

# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer Nmap
echo "Installation de Nmap..."
sudo apt install -y nmap

# Installer Nikto
echo "Installation de Nikto..."
sudo apt install -y git
git clone https://github.com/sullo/nikto.git /root/nikto
cd /root/nikto/program
sudo perl nikto.pl -update

# Revenir au répertoire de base
cd /root

# Installer Lynis
echo "Installation de Lynis..."
sudo apt install -y lynis

# Installer Pandoc et pdflatex
echo "Installation de Pandoc et pdflatex..."
sudo apt install -y pandoc texlive-latex-base

# Installer ssconvert pour convertir XLS en XLSX
echo "Installation de ssconvert..."
sudo apt install -y gnumeric

# Installer les dépendances Python
echo "Installation de Python et Tkinter..."
sudo apt install -y python3 python3-pip python3-tk

# Créer un environnement virtuel et installer les dépendances Python
python3 -m venv myenv
source myenv/bin/activate
pip install pandas openpyxl tk

echo "Installation terminée ! Vous pouvez maintenant exécuter l'interface graphique avec 'source /home/charly/myenv/bin/activate && python3 script_runner.py'."
