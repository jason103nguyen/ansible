# 🖥️ Windows Setup Guide

## 📋 System Requirements

### 1. Install Required Tools

- **VirtualBox**: [Download](https://www.virtualbox.org/wiki/Downloads)
- **Vagrant**: [Download](https://www.vagrantup.com/downloads)
- **Git for Windows**: [Download](https://git-scm.com/download/win) (includes Git Bash)
- **Ansible**: Can be installed via WSL or using Git Bash

### 2. Install Ansible

#### Option 1: Using WSL (Recommended)

1. Install WSL:
```powershell
wsl --install
```

2. In WSL Ubuntu, install Ansible:
```bash
sudo apt update
sudo apt install ansible
```

#### Option 2: Using Git Bash

1. Open Git Bash as Administrator
2. Install Python and pip if not already installed
3. Install Ansible:
```bash
pip install ansible
```

## 🚀 Running Scripts

### With Git Bash

Open Git Bash in the project directory:

```bash
# Navigate to project
cd /path/to/ansible-practice

# Vagrant commands
vagrant up
vagrant status
vagrant ssh node1

# Ansible commands
ansible all -m ping
ansible-playbook site.yml
```

### With PowerShell

```powershell
# Use PowerShell script for Vagrant
.\vagrant.ps1 up

# For Ansible, use WSL
wsl ansible all -m ping
```

### With WSL

```bash
# All commands work normally in WSL
vagrant up
ansible all -m ping
ansible-playbook site.yml
```

## 🔧 Alternative Commands

If scripts don't work, use direct commands:

### Vagrant
```bash
vagrant up          # Start VMs
vagrant halt        # Stop VMs
vagrant status      # View status
vagrant ssh node1   # SSH to node1
```

### Ansible
```bash
ansible all -m ping                     # Test connection
ansible all -m gather_facts             # Gather facts
ansible-playbook site.yml               # Run playbook
```

## 💡 Important Notes

- Always run Git Bash **as Administrator** for Vagrant
- If using WSL, all Linux commands work normally
- VirtualBox may require enabling virtualization in BIOS
- Windows Defender may block some operations

### Permission Errors
```bash
# Run as Administrator
```

### SSH Errors
```bash
# In Git Bash or WSL
bash scripts/copy-keys-vagrant.sh
```

### Vagrant Errors
```bash
vagrant destroy -f    # Delete and recreate
vagrant up
``` 