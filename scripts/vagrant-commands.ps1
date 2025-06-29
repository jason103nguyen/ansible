param([string]$command)

Write-Host "🔧 Vagrant Commands Helper (PowerShell)" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

switch($command) {
    "start" {
        Write-Host "🚀 Starting all VMs..." -ForegroundColor Green
        vagrant up
    }
    "stop" {
        Write-Host "⏹️  Stopping all VMs..." -ForegroundColor Yellow
        vagrant halt
    }
    "restart" {
        Write-Host "🔄 Restarting all VMs..." -ForegroundColor Blue
        vagrant reload
    }
    "status" {
        Write-Host "📊 VM Status..." -ForegroundColor Magenta
        vagrant status
    }
    "ssh1" {
        Write-Host "🔌 SSH to node1..." -ForegroundColor Green
        vagrant ssh node1
    }
    "ssh2" {
        Write-Host "🔌 SSH to node2..." -ForegroundColor Green
        vagrant ssh node2
    }
    "ssh3" {
        Write-Host "🔌 SSH to node3..." -ForegroundColor Green
        vagrant ssh node3
    }
    "destroy" {
        Write-Host "💥 Destroying all VMs..." -ForegroundColor Red
        $response = Read-Host "⚠️  Are you sure you want to destroy all VMs? (y/N)"
        if ($response -match "^[Yy]$") {
            vagrant destroy -f
        } else {
            Write-Host "Operation cancelled" -ForegroundColor Yellow
        }
    }
    "provision" {
        Write-Host "⚙️  Provisioning all VMs..." -ForegroundColor Blue
        vagrant provision
    }
    default {
        Write-Host "Usage: .\vagrant-commands.ps1 {command}" -ForegroundColor White
        Write-Host ""
        Write-Host "Available commands:" -ForegroundColor White
        Write-Host "  start      - Start all VMs" -ForegroundColor Gray
        Write-Host "  stop       - Stop all VMs" -ForegroundColor Gray
        Write-Host "  restart    - Restart VMs" -ForegroundColor Gray
        Write-Host "  status     - Show VM status" -ForegroundColor Gray
        Write-Host "  ssh1/2/3   - SSH to corresponding node" -ForegroundColor Gray
        Write-Host "  destroy    - Destroy all VMs" -ForegroundColor Gray
        Write-Host "  provision  - Re-provision VMs" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Example: .\vagrant-commands.ps1 start" -ForegroundColor Cyan
    }
} 