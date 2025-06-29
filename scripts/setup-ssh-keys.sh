#!/bin/bash

# Script to setup SSH keys for Ansible
echo "🔑 Setting up SSH Keys for Ansible..."

# Create .ssh directory if it doesn't exist
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Create SSH key pair for Ansible (no passphrase for automation)
if [ ! -f ~/.ssh/ansible_key ]; then
    echo "Creating new SSH key pair..."
    ssh-keygen -t ed25519 -f ~/.ssh/ansible_key -N "" -C "ansible-automation-key"
    echo "✅ SSH key created at ~/.ssh/ansible_key"
else
    echo "SSH key already exists at ~/.ssh/ansible_key"
fi

# Display public key
echo ""
echo "📋 Your public key:"
cat ~/.ssh/ansible_key.pub

echo ""
echo "🚀 To copy key to servers, use:"
echo "ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.101"
echo "ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.102"
echo "ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.103"

echo ""
echo "🔧 Or run copy-keys.sh script after VMs are ready" 