#!/bin/bash

# Script containing Ansible commands for practice

echo "🔧 Ansible Commands Helper"
echo "========================="

case "$1" in
    "ping")
        echo "🏓 Testing ping to all hosts..."
        ansible all -m ping
        ;;
    "facts")
        echo "📊 Gathering facts from all hosts..."
        ansible all -m gather_facts
        ;;
    "uptime")
        echo "⏰ Checking uptime..."
        ansible all -a "uptime"
        ;;
    "disk")
        echo "💿 Checking disk usage..."
        ansible all -a "df -h"
        ;;
    "memory")
        echo "🧠 Checking memory..."
        ansible all -a "free -h"
        ;;
    "update")
        echo "🔄 Updating package cache..."
        ansible all -m apt -a "update_cache=true" --become
        ;;
    "install")
        if [ -z "$2" ]; then
            echo "❌ Please provide package name"
            echo "Example: $0 install htop"
            exit 1
        fi
        echo "📦 Installing package $2..."
        ansible all -m apt -a "name=$2 state=latest" --become
        ;;
    "service")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ Please provide service name and state"
            echo "Example: $0 service apache2 started"
            exit 1
        fi
        echo "⚙️  Managing service $2..."
        ansible all -m service -a "name=$2 state=$3" --become
        ;;
    "copy")
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "❌ Please provide source and destination files"
            echo "Example: $0 copy /local/file /remote/path"
            exit 1
        fi
        echo "📁 Copying file $2 -> $3..."
        ansible all -m copy -a "src=$2 dest=$3" --become
        ;;
    "bootstrap")
        echo "🚀 Running bootstrap playbook..."
        ansible-playbook bootstrap.yml --ask-become-pass
        ;;
    "site")
        echo "🌐 Running site playbook..."
        ansible-playbook site.yml
        ;;
    "test")
        echo "🧪 Running test playbook..."
        ansible-playbook test-playbook.yml
        ;;
    "web")
        echo "🌐 Running web servers only..."
        ansible-playbook site.yml --tags web
        ;;
    "db")
        echo "🗄️  Running database servers only..."
        ansible-playbook site.yml --tags db
        ;;
    "limit")
        if [ -z "$2" ]; then
            echo "❌ Please provide hostname"
            echo "Example: $0 limit node1"
            exit 1
        fi
        echo "🎯 Running command only on $2..."
        ansible all -m ping --limit $2
        ;;
    "list-tags")
        echo "🏷️  Listing tags in site.yml..."
        ansible-playbook site.yml --list-tags
        ;;
    "list-hosts")
        echo "🖥️  Listing hosts..."
        ansible all --list-hosts
        ;;
    "groups")
        echo "👥 Listing groups..."
        ansible-inventory --list
        ;;
    *)
        echo "Usage: $0 {command} [args...]"
        echo ""
        echo "📋 Basic commands:"
        echo "  ping              - Test connection"
        echo "  facts             - Gather system facts"
        echo "  uptime            - Check uptime"
        echo "  disk              - Check disk space"
        echo "  memory            - Check memory"
        echo ""
        echo "📦 Package management:"
        echo "  update            - Update package cache"
        echo "  install <pkg>     - Install package"
        echo ""
        echo "⚙️  Service management:"
        echo "  service <name> <state> - Manage service"
        echo ""
        echo "📁 File management:"
        echo "  copy <src> <dest> - Copy file"
        echo ""
        echo "🎯 Playbooks:"
        echo "  bootstrap         - Run bootstrap"
        echo "  site              - Run site playbook"
        echo "  test              - Run test playbook"
        echo "  web               - Web servers only"
        echo "  db                - Database servers only"
        echo ""
        echo "🔍 Information:"
        echo "  limit <host>      - Limit to specific host"
        echo "  list-tags         - List tags"
        echo "  list-hosts        - List hosts"
        echo "  groups            - List groups"
        ;;
esac 