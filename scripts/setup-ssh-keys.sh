#!/bin/bash

# Script để setup SSH keys cho Ansible
echo "🔑 Thiết lập SSH Keys cho Ansible..."

# Tạo thư mục .ssh nếu chưa có
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Tạo SSH key pair cho Ansible (không có passphrase để tự động hóa)
if [ ! -f ~/.ssh/ansible_key ]; then
    echo "Tạo SSH key pair mới..."
    ssh-keygen -t ed25519 -f ~/.ssh/ansible_key -N "" -C "ansible-automation-key"
    echo "✅ SSH key đã được tạo tại ~/.ssh/ansible_key"
else
    echo "SSH key đã tồn tại tại ~/.ssh/ansible_key"
fi

# Hiển thị public key
echo ""
echo "📋 Public key của bạn:"
cat ~/.ssh/ansible_key.pub

echo ""
echo "🚀 Để copy key lên các máy chủ, sử dụng:"
echo "ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.101"
echo "ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.102"
echo "ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.103"

echo ""
echo "🔧 Hoặc chạy script copy-keys.sh sau khi các VM đã sẵn sàng" 