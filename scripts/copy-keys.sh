#!/bin/bash

# Script để copy SSH keys lên tất cả các máy chủ
echo "🔑 Copy SSH keys lên các máy chủ..."

# Danh sách các máy chủ
SERVERS=("192.168.56.101" "192.168.56.102" "192.168.56.103")

# Copy key lên từng máy chủ
for server in "${SERVERS[@]}"; do
    echo "📤 Copy key lên $server..."
    ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@$server
    
    if [ $? -eq 0 ]; then
        echo "✅ Thành công copy key lên $server"
    else
        echo "❌ Lỗi khi copy key lên $server"
    fi
    echo ""
done

echo "🧪 Test kết nối SSH..."
for server in "${SERVERS[@]}"; do
    echo "Test $server..."
    ssh -i ~/.ssh/ansible_key -o ConnectTimeout=5 vagrant@$server "echo 'SSH connection successful to $server'"
done

echo ""
echo "✅ Hoàn thành! Bây giờ bạn có thể chạy:"
echo "ansible all -m ping" 