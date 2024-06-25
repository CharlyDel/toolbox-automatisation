import tkinter as tk
from tkinter import filedialog, messagebox
import subprocess
import os
from datetime import datetime

def run_script():
    ip_address = ip_entry.get()
    output_dir = output_entry.get()
    tool = tool_var.get()

    if not ip_address:
        messagebox.showerror("Error", "Please enter an IP address.")
        return

    if not output_dir:
        output_dir = f"/home/{os.getlogin()}/report/{datetime.now().strftime('%Y%m%d_%H%M%S')}/"
        os.makedirs(output_dir, exist_ok=True)

    if tool not in ["Nikto", "Nmap", "Both"]:
        messagebox.showerror("Error", "Please select a valid tool.")
        return

    command = ["bash", "Main.sh", ip_address, output_dir, tool]
    result = subprocess.run(command, capture_output=True, text=True)

    if result.returncode == 0:
        messagebox.showinfo("Success", f"Script completed. Report saved to {output_dir}/report.pdf")
    else:
        messagebox.showerror("Error", f"Script failed with error: {result.stderr}")

# Configuration de l'interface graphique
root = tk.Tk()
root.title("Security Tool Runner")

# Champ pour entrer l'adresse IP
tk.Label(root, text="IP Address:").grid(row=0, column=0, padx=10, pady=10)
ip_entry = tk.Entry(root, width=50)
ip_entry.grid(row=0, column=1, padx=10, pady=10)

# Champ pour entrer le dossier de sortie
tk.Label(root, text="Output Directory:").grid(row=1, column=0, padx=10, pady=10)
output_entry = tk.Entry(root, width=50)
output_entry.grid(row=1, column=1, padx=10, pady=10)

# Bouton pour choisir le dossier de sortie
def choose_directory():
    dir_name = filedialog.askdirectory()
    if dir_name:
        output_entry.delete(0, tk.END)
        output_entry.insert(0, dir_name)

tk.Button(root, text="Browse...", command=choose_directory).grid(row=1, column=2, padx=10, pady=10)

# Menu déroulant pour choisir l'outil
tk.Label(root, text="Tool:").grid(row=2, column=0, padx=10, pady=10)
tool_var = tk.StringVar()
tool_menu = tk.OptionMenu(root, tool_var, "Nikto", "Nmap", "Both")
tool_menu.grid(row=2, column=1, padx=10, pady=10)
tool_var.set("Nikto")  # Valeur par défaut

# Bouton pour lancer le script
tk.Button(root, text="Run Script", command=run_script).grid(row=3, column=1, padx=10, pady=20)

root.mainloop()
