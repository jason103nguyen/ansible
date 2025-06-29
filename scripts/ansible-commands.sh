#!/bin/bash

# Script chứa các lệnh Ansible để thực hành

echo "🔧 Ansible Commands Helper"
echo "========================="

case "$1" in
    "ping")
        echo "🏓 Test ping tất cả máy chủ..."
        ansible all -m ping
        ;;
    "facts")
        echo "📊 Thu thập facts từ tất cả máy chủ..."
        ansible all -m gather_facts
        ;;
    "uptime")
        echo "⏰ Kiểm tra uptime..."
        ansible all -a "uptime"
        ;;
    "disk")
        echo "💿 Kiểm tra dung lượng disk..."
        ansible all -a "df -h"
        ;;
    "memory")
        echo "🧠 Kiểm tra memory..."
        ansible all -a "free -h"
        ;;
    "update")
        echo "🔄 Update package cache..."
        ansible all -m apt -a "update_cache=true" --become
        ;;
    "install")
        if [ -z "$2" ]; then
            echo "❌ Vui lòng cung cấp tên package"
            echo "Ví dụ: $0 install htop"
            exit 1
        fi
        echo "📦 Cài đặt package $2..."
        ansible all -m apt -a "name=$2 state=latest" --become
        ;;
    "service")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ Vui lòng cung cấp tên service và trạng thái"
            echo "Ví dụ: $0 service apache2 started"
            exit 1
        fi
        echo "⚙️  Quản lý service $2..."
        ansible all -m service -a "name=$2 state=$3" --become
        ;;
    "copy")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ Vui lòng cung cấp file nguồn và đích"
            echo "Ví dụ: $0 copy /local/file /remote/path"
            exit 1
        fi
        echo "📁 Copy file $2 -> $3..."
        ansible all -m copy -a "src=$2 dest=$3" --become
        ;;
    "bootstrap")
        echo "🚀 Chạy bootstrap playbook..."
        ansible-playbook bootstrap.yml --ask-become-pass
        ;;
    "site")
        echo "🌐 Chạy site playbook..."
        ansible-playbook site.yml
        ;;
    "test")
        echo "🧪 Chạy test playbook..."
        ansible-playbook test-playbook.yml
        ;;
    "web")
        echo "🌐 Chạy chỉ web servers..."
        ansible-playbook site.yml --tags web
        ;;
    "db")
        echo "🗄️  Chạy chỉ database servers..."
        ansible-playbook site.yml --tags db
        ;;
    "limit")
        if [ -z "$2" ]; then
            echo "❌ Vui lòng cung cấp hostname"
            echo "Ví dụ: $0 limit node1"
            exit 1
        fi
        echo "🎯 Chạy lệnh chỉ trên $2..."
        ansible all -m ping --limit $2
        ;;
    "list-tags")
        echo "🏷️  Liệt kê tags trong site.yml..."
        ansible-playbook site.yml --list-tags
        ;;
    "list-hosts")
        echo "🖥️  Liệt kê hosts..."
        ansible all --list-hosts
        ;;
    "groups")
        echo "👥 Liệt kê groups..."
        ansible-inventory --list
        ;;
    *)
        echo "Sử dụng: $0 {command} [args...]"
        echo ""
        echo "📋 Lệnh cơ bản:"
        echo "  ping              - Test kết nối"
        echo "  facts             - Thu thập system facts"
        echo "  uptime            - Kiểm tra uptime"
        echo "  disk              - Kiểm tra disk space"
        echo "  memory            - Kiểm tra memory"
        echo ""
        echo "📦 Quản lý packages:"
        echo "  update            - Update package cache"
        echo "  install <pkg>     - Cài đặt package"
        echo ""
        echo "⚙️  Quản lý services:"
        echo "  service <name> <state> - Quản lý service"
        echo ""
        echo "📁 Quản lý files:"
        echo "  copy <src> <dest> - Copy file"
        echo ""
        echo "🎯 Playbooks:"
        echo "  bootstrap         - Chạy bootstrap"
        echo "  site              - Chạy site playbook"
        echo "  test              - Chạy test playbook"
        echo "  web               - Chỉ web servers"
        echo "  db                - Chỉ database servers"
        echo ""
        echo "🔍 Thông tin:"
        echo "  limit <host>      - Giới hạn host cụ thể"
        echo "  list-tags         - Liệt kê tags"
        echo "  list-hosts        - Liệt kê hosts"
        echo "  groups            - Liệt kê groups"
        ;;
esac 