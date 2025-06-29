#!/bin/bash

# Script to copy SSH keys via Vagrant SSH
echo "🔑 Copying SSH keys via Vagrant SSH..."

# Check if SSH key exists
if [ ! -f ~/.ssh/ansible_key.pub ]; then
    echo "❌ SSH key does not exist. Run scripts/setup-ssh-keys.sh first"
    exit 1
fi

# Copy key to each VM
for i in {1..3}; do
    echo "📤 Copying key to node$i..."
    
    # Create .ssh directory in VM
    vagrant ssh node$i -c "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
    
    # Copy public key to authorized_keys
    vagrant ssh node$i -c "echo '$(cat ~/.ssh/ansible_key.pub)' >> ~/.ssh/authorized_keys"
    
    # Set correct permissions
    vagrant ssh node$i -c "chmod 600 ~/.ssh/authorized_keys"
    
    # Remove duplicate keys
    vagrant ssh node$i -c "sort ~/.ssh/authorized_keys | uniq > ~/.ssh/authorized_keys.tmp && mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys"
    
    echo "✅ Completed node$i"
done

echo ""
echo "🧪 Testing SSH connections..."
for i in {1..3}; do
    echo "Testing node$i (192.168.56.10$i)..."
    ssh -i ~/.ssh/ansible_key -o ConnectTimeout=5 -o StrictHostKeyChecking=no vagrant@192.168.56.10$i "echo 'SSH connection successful to node$i'"
done

echo ""
echo "✅ Complete! Now you can run:"
echo "ansible all -m ping" 