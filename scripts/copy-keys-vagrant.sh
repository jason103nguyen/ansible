#!/bin/bash

# Script để copy SSH keys qua Vagrant SSH
echo "🔑 Copy SSH keys qua Vagrant SSH..."

# Kiểm tra SSH key có tồn tại không
if [ ! -f ~/.ssh/ansible_key.pub ]; then
    echo "❌ SSH key không tồn tại. Chạy scripts/setup-ssh-keys.sh trước"
    exit 1
fi

# Copy key lên từng VM
for i in {1..3}; do
    echo "📤 Copy key lên node$i..."
    
    # Tạo thư mục .ssh trong VM
    vagrant ssh node$i -c "mkdir -p ~/.ssh && chmod 700 ~/.ssh"
    
    # Copy public key vào authorized_keys
    vagrant ssh node$i -c "echo '$(cat ~/.ssh/ansible_key.pub)' >> ~/.ssh/authorized_keys"
    
    # Set đúng permissions
    vagrant ssh node$i -c "chmod 600 ~/.ssh/authorized_keys"
    
    # Remove duplicate keys
    vagrant ssh node$i -c "sort ~/.ssh/authorized_keys | uniq > ~/.ssh/authorized_keys.tmp && mv ~/.ssh/authorized_keys.tmp ~/.ssh/authorized_keys"
    
    echo "✅ Hoàn thành node$i"
done

echo ""
echo "🧪 Test kết nối SSH..."
for i in {1..3}; do
    echo "Test node$i (192.168.56.10$i)..."
    ssh -i ~/.ssh/ansible_key -o ConnectTimeout=5 -o StrictHostKeyChecking=no vagrant@192.168.56.10$i "echo 'SSH connection successful to node$i'"
done

echo ""
echo "✅ Hoàn thành! Bây giờ bạn có thể chạy:"
echo "ansible all -m ping" 