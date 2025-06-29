# 🚀 Ansible Practice Environment

This is a complete practice environment for the "Getting Started with Ansible" series, designed to help you practice all basic Ansible knowledge.

## 📋 Directory Structure

```
ansible-practice/
├── Vagrantfile                 # Configuration for 3 Ubuntu VMs
├── ansible.cfg                 # Ansible configuration
├── inventory                   # Host inventory
├── bootstrap.yml               # Bootstrap playbook
├── site.yml                    # Main playbook
├── test-playbook.yml           # Test playbook
├── group_vars/                 # Variables for groups
│   ├── all.yml
│   ├── web_servers.yml
│   └── db_servers.yml
├── host_vars/                  # Variables for individual hosts
│   ├── node1.yml
│   ├── node2.yml
│   └── node3.yml
├── roles/                      # Ansible roles
│   ├── base/
│   ├── webserver/
│   ├── database/
│   └── fileserver/
├── templates/                  # Jinja2 templates
├── scripts/                    # Helper scripts
│   ├── setup-ssh-keys.sh
│   ├── copy-keys.sh
│   ├── copy-keys-vagrant.sh
│   ├── vagrant-commands.sh
│   └── ansible-commands.sh
└── README.md
```

## 🔧 Initial Setup

### 1. Start the VMs

```bash
# Start all VMs
vagrant up

# Or use helper script
bash scripts/vagrant-commands.sh start
```

### 2. Setup SSH Keys

```bash
# Create SSH keys for Ansible
bash scripts/setup-ssh-keys.sh

# Copy keys to VMs (after VMs are running)
bash scripts/copy-keys-vagrant.sh
```

### 3. Test connection

```bash
ansible all -m ping

# Or use helper script
bash scripts/ansible-commands.sh ping
```

## 🎯 Practice by Topic

### 1. Ad-hoc Commands

```bash
# Test connection
ansible all -m ping

# Gather facts
ansible all -m gather_facts

# Check uptime
ansible all -a "uptime"

# Install package
ansible all -m apt -a "name=htop state=latest" --become

# Manage service
ansible all -m service -a "name=apache2 state=started" --become
```

### 2. Inventory and Groups

```bash
# List all hosts
ansible all --list-hosts

# List hosts in group
ansible web_servers --list-hosts

# Run command only on one group
ansible web_servers -m ping

# Limit command to one host
ansible all -m ping --limit node1
```

### 3. Variables and Facts

```bash
# View variables of a host
ansible node1 -m debug -a "var=hostvars[inventory_hostname]"

# View specific fact
ansible all -m debug -a "var=ansible_distribution"

# Use variables in ad-hoc
ansible all -m debug -a "msg='Hello from {{ ansible_hostname }}'"
```

### 4. Playbooks

```bash
# Run test playbook
ansible-playbook test-playbook.yml

# Run with specific tags
ansible-playbook test-playbook.yml --tags packages

# Dry run (check without executing)
ansible-playbook test-playbook.yml --check
```

### 5. Roles and Tags

```bash
# Run site playbook (using roles)
ansible-playbook bootstrap.yml
ansible-playbook site.yml

# Run only web servers
ansible-playbook site.yml --tags web

# Run only database servers
ansible-playbook site.yml --tags db
```

### 6. Templates and Handlers

```bash
# Run playbook using templates
ansible-playbook site.yml --tags base

# Check file created from template
ansible all -a "cat /tmp/test-file.txt"
```

## 🔧 Helper Scripts

### Vagrant Commands

```bash
bash scripts/vagrant-commands.sh start      # Start VMs
bash scripts/vagrant-commands.sh stop       # Stop VMs
bash scripts/vagrant-commands.sh status     # View status
bash scripts/vagrant-commands.sh ssh1       # SSH to node1
```

### Ansible Commands

```bash
bash scripts/ansible-commands.sh ping       # Test connection
bash scripts/ansible-commands.sh facts      # Gather facts
bash scripts/ansible-commands.sh uptime     # Check uptime
bash scripts/ansible-commands.sh install htop # Install package
bash scripts/ansible-commands.sh bootstrap  # Run bootstrap
bash scripts/ansible-commands.sh site       # Run site playbook
```

## 🧪 Practice Exercises

### Exercise 1: Basic Ad-hoc Commands
1. Test connection to all hosts
2. Check disk space on all servers
3. Install a package on web servers only

### Exercise 2: Inventory and Groups
1. List all hosts in web_servers group
2. Run a command only on database servers
3. Use --limit to target specific host

### Exercise 3: Playbooks and Variables
1. Create a simple playbook
2. Use group_vars and host_vars
3. Use templates with variables

### Exercise 4: Roles and Tags
1. Run only specific roles
2. Use tags to run partial playbooks
3. Override variables for specific hosts

### Exercise 5: Templates and Handlers
1. Create a template file
2. Use handlers to restart services
3. Test idempotency

## 🌐 Access Services

After running the playbooks, you can access:

- **Web Servers**: 
  - Node1: http://192.168.56.101
  - Node2: http://192.168.56.102
- **SSH Access**: 
  - `vagrant ssh node1`
  - `vagrant ssh node2` 
  - `vagrant ssh node3`

## 🔧 Troubleshooting

### SSH Issues
```bash
# Check SSH key
ls -la ~/.ssh/ansible_key*

# Copy key again if needed
bash scripts/copy-keys-vagrant.sh
```

### Permission Issues
```bash
# Run with sudo
ansible-playbook site.yml --ask-become-pass
```

### VM Issues
```bash
# Destroy and recreate
vagrant destroy -f
vagrant up
```

## 📚 Knowledge Practiced

- ✅ Ad-hoc commands
- ✅ Inventory management
- ✅ Playbooks and tasks
- ✅ Variables and facts
- ✅ Templates (Jinja2)
- ✅ Roles and role structure
- ✅ Handlers and notifications
- ✅ Tags and conditional execution
- ✅ Group variables and host variables
- ✅ Ansible Vault basics
- ✅ Best practices and project structure

Happy practicing! 🎉 