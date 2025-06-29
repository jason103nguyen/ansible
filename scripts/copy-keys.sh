#!/bin/bash

# Script to copy SSH keys to all servers
echo "🔑 Copying SSH keys to servers..."

# List of servers
SERVERS=("192.168.56.101" "192.168.56.102" "192.168.56.103")

# Copy key to each server
for server in "${SERVERS[@]}"; do
    echo "📤 Copying key to $server..."
    ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@$server
    
    if [ $? -eq 0 ]; then
        echo "✅ Successfully copied key to $server"
    else
        echo "❌ Error copying key to $server"
    fi
    echo ""
done

echo "🧪 Testing SSH connections..."
for server in "${SERVERS[@]}"; do
    echo "Testing $server..."
    ssh -i ~/.ssh/ansible_key -o ConnectTimeout=5 vagrant@$server "echo 'SSH connection successful to $server'"
done

echo ""
echo "✅ Complete! Now you can run:"
echo "ansible all -m ping" 