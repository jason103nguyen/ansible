param([string]$command)

Write-Host "🔧 Vagrant Commands Helper (PowerShell)" -ForegroundColor Cyan
Write-Host "======================================" -ForegroundColor Cyan

switch($command) {
    "start" {
        Write-Host "🚀 Khởi động tất cả VM..." -ForegroundColor Green
        vagrant up
    }
    "stop" {
        Write-Host "⏹️  Dừng tất cả VM..." -ForegroundColor Yellow
        vagrant halt
    }
    "restart" {
        Write-Host "🔄 Khởi động lại tất cả VM..." -ForegroundColor Blue
        vagrant reload
    }
    "status" {
        Write-Host "📊 Trạng thái VM..." -ForegroundColor Magenta
        vagrant status
    }
    "ssh1" {
        Write-Host "🔌 SSH vào node1..." -ForegroundColor Green
        vagrant ssh node1
    }
    "ssh2" {
        Write-Host "🔌 SSH vào node2..." -ForegroundColor Green
        vagrant ssh node2
    }
    "ssh3" {
        Write-Host "🔌 SSH vào node3..." -ForegroundColor Green
        vagrant ssh node3
    }
    "destroy" {
        Write-Host "💥 Xóa tất cả VM..." -ForegroundColor Red
        $response = Read-Host "⚠️  Bạn có chắc muốn xóa tất cả VM? (y/N)"
        if ($response -match "^[Yy]$") {
            vagrant destroy -f
        } else {
            Write-Host "Hủy thao tác" -ForegroundColor Yellow
        }
    }
    "provision" {
        Write-Host "⚙️  Provision lại tất cả VM..." -ForegroundColor Blue
        vagrant provision
    }
    default {
        Write-Host "Sử dụng: .\vagrant-commands.ps1 {command}" -ForegroundColor White
        Write-Host ""
        Write-Host "Lệnh có sẵn:" -ForegroundColor White
        Write-Host "  start      - Khởi động tất cả VM" -ForegroundColor Gray
        Write-Host "  stop       - Dừng tất cả VM" -ForegroundColor Gray
        Write-Host "  restart    - Khởi động lại VM" -ForegroundColor Gray
        Write-Host "  status     - Xem trạng thái VM" -ForegroundColor Gray
        Write-Host "  ssh1/2/3   - SSH vào node tương ứng" -ForegroundColor Gray
        Write-Host "  destroy    - Xóa tất cả VM" -ForegroundColor Gray
        Write-Host "  provision  - Provision lại VM" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Ví dụ: .\vagrant-commands.ps1 start" -ForegroundColor Cyan
    }
} 