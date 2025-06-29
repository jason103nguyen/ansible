#!/bin/bash

# Script chứa các lệnh Vagrant hữu ích

echo "🔧 Vagrant Commands Helper"
echo "=========================="

case "$1" in
    "start")
        echo "🚀 Khởi động tất cả VM..."
        vagrant up
        ;;
    "stop")
        echo "⏹️  Dừng tất cả VM..."
        vagrant halt
        ;;
    "restart")
        echo "🔄 Khởi động lại tất cả VM..."
        vagrant reload
        ;;
    "status")
        echo "📊 Trạng thái VM..."
        vagrant status
        ;;
    "ssh1")
        echo "🔌 SSH vào node1..."
        vagrant ssh node1
        ;;
    "ssh2")
        echo "🔌 SSH vào node2..."
        vagrant ssh node2
        ;;
    "ssh3")
        echo "🔌 SSH vào node3..."
        vagrant ssh node3
        ;;
    "destroy")
        echo "💥 Xóa tất cả VM..."
        echo "⚠️  Bạn có chắc muốn xóa tất cả VM? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            vagrant destroy -f
        else
            echo "Hủy thao tác"
        fi
        ;;
    "provision")
        echo "⚙️  Provision lại tất cả VM..."
        vagrant provision
        ;;
    *)
        echo "Sử dụng: $0 {start|stop|restart|status|ssh1|ssh2|ssh3|destroy|provision}"
        echo ""
        echo "Lệnh có sẵn:"
        echo "  start      - Khởi động tất cả VM"
        echo "  stop       - Dừng tất cả VM"
        echo "  restart    - Khởi động lại VM"
        echo "  status     - Xem trạng thái VM"
        echo "  ssh1/2/3   - SSH vào node tương ứng"
        echo "  destroy    - Xóa tất cả VM"
        echo "  provision  - Provision lại VM"
        ;;
esac 