#!/bin/bash

# Script containing useful Vagrant commands

echo "🔧 Vagrant Commands Helper"
echo "=========================="

case "$1" in
    "start")
        echo "🚀 Starting all VMs..."
        vagrant up
        ;;
    "stop")
        echo "⏹️  Stopping all VMs..."
        vagrant halt
        ;;
    "restart")
        echo "🔄 Restarting all VMs..."
        vagrant reload
        ;;
    "status")
        echo "📊 VM Status..."
        vagrant status
        ;;
    "ssh1")
        echo "🔌 SSH to node1..."
        vagrant ssh node1
        ;;
    "ssh2")
        echo "🔌 SSH to node2..."
        vagrant ssh node2
        ;;
    "ssh3")
        echo "🔌 SSH to node3..."
        vagrant ssh node3
        ;;
    "destroy")
        echo "💥 Destroying all VMs..."
        echo "⚠️  Are you sure you want to destroy all VMs? (y/N)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            vagrant destroy -f
        else
            echo "Operation cancelled"
        fi
        ;;
    "provision")
        echo "⚙️  Provisioning all VMs..."
        vagrant provision
        ;;
    *)
        echo "Usage: $0 {start|stop|restart|status|ssh1|ssh2|ssh3|destroy|provision}"
        echo ""
        echo "Available commands:"
        echo "  start      - Start all VMs"
        echo "  stop       - Stop all VMs"
        echo "  restart    - Restart VMs"
        echo "  status     - Show VM status"
        echo "  ssh1/2/3   - SSH to corresponding node"
        echo "  destroy    - Destroy all VMs"
        echo "  provision  - Re-provision VMs"
        ;;
esac 