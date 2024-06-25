Security Tool Runner
Description

Security Tool Runner is a project that allows users to run security scans using Nikto and Nmap tools. The results of the scans are converted into a PDF report. The project includes an installation script, a graphical user interface (GUI), and scripts to execute the scans and generate the report.
Features

    Run Nikto, Nmap, or both scans on a specified IP address.
    Save the scan results to a specified output directory.
    Convert Nmap results to a PDF report.
    Simple GUI to input parameters and run the scans.

Prerequisites

    Debian-based Linux distribution.
    Python 3.7 or higher.

Installation
Step 1: Clone the repository

bash

git clone https://github.com/CharlyDel/toolbox-automatisation
cd https://github.com/CharlyDel/toolbox-automatisation.git

Step 2: Run the installation script

bash

sudo ./install_tools.sh

This script will:

    Update the system packages.
    Install Nmap, Git, Lynis, Pandoc, pdflatex, and other necessary tools.
    Clone the Nikto repository.
    Install Python and required packages in a virtual environment.

Usage
Step 1: Activate the virtual environment

bash

source /home/{USER}/myenv/bin/activate

Step 2: Run the GUI script

bash

python3 script_runner.py

Step 3: Use the GUI

    IP Address: Enter the IP address to scan.
    Output Directory: Choose the output directory to save the scan results. If not specified, a default directory will be created.
    Tool: Select the tool to use (Nikto, Nmap, or Both).
    Click on Run Script to start the scan.

Step 4: View the Report

Once the scan is complete, the PDF report will be saved in the specified output directory.
Script Descriptions
Main.sh

This script accepts three parameters (IP address, output directory, and tool) and runs the selected tool. It then converts the Nmap results to a PDF report.
Nmap.sh

This script runs an Nmap scan on the specified IP address and converts the results from XML to XLS and then to XLSX.
Nikto.sh

This script runs a Nikto scan on the specified IP address.
install_tools.sh

This script installs all the necessary tools and dependencies for the project.
script_runner.py

This script provides a GUI for the user to input parameters and run the scan scripts.
Example

bash

source /home/{USER]/myenv/bin/activate
python3 script_runner.py

    Enter 8.8.8.8 as the IP address.
    Choose /home/charly/report/ as the output directory.
    Select Both from the tool options.
    Click Run Script.
    After the scan completes, view the report at /home/charly/report/<timestamp>/report.pdf.

Troubleshooting

If you encounter any issues, please ensure that all prerequisites are met and that the installation script ran without errors. For further assistance, check the log files generated in the output directory.