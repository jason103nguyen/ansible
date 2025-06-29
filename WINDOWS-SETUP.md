# 🖥️ Hướng Dẫn Setup Trên Windows

## 📋 Yêu Cầu Hệ Thống

### 1. Cài Đặt Các Tool Cần Thiết

- **VirtualBox**: [Download](https://www.virtualbox.org/wiki/Downloads)
- **Vagrant**: [Download](https://www.vagrantup.com/downloads)
- **Git for Windows**: [Download](https://git-scm.com/download/win) (bao gồm Git Bash)
- **Ansible**: Có thể cài qua WSL hoặc sử dụng Git Bash

### 2. Cài Đặt Ansible

#### Phương Án 1: Sử dụng WSL (Khuyến Nghị)

1. Cài đặt WSL:
```powershell
wsl --install
```

2. Trong WSL Ubuntu, cài Ansible:
```bash
sudo apt update
sudo apt install ansible
```

#### Phương Án 2: Sử dụng Git Bash

1. Mở Git Bash as Administrator
2. Cài đặt Python và pip nếu chưa có
3. Cài Ansible:
```bash
pip install ansible
```

## 🚀 Chạy Scripts

### Với Git Bash

Mở Git Bash trong thư mục dự án:

```bash
# Setup SSH keys
bash scripts/setup-ssh-keys.sh

# Các lệnh Vagrant
bash scripts/vagrant-commands.sh start

# Các lệnh Ansible
bash scripts/ansible-commands.sh ping
```

### Với PowerShell

```powershell
# Sử dụng script PowerShell cho Vagrant
.\scripts\vagrant-commands.ps1 start
.\scripts\vagrant-commands.ps1 status
```

### Với WSL

```bash
cd /mnt/c/ansible_lab
bash scripts/setup-ssh-keys.sh
```

## 🔧 Commands Thay Thế

### Vagrant Commands (PowerShell)

```powershell
vagrant up          # Khởi động VM
vagrant halt        # Dừng VM
vagrant status      # Xem trạng thái
vagrant ssh node1   # SSH vào node1
```

### Ansible Commands (WSL/Git Bash)

```bash
ansible all -m ping                    # Test ping
ansible all -m gather_facts           # Thu thập facts
ansible-playbook site.yml             # Chạy playbook
```

## 💡 Lưu Ý Quan Trọng

1. **Script Files**: Trên Windows cần dùng Git Bash hoặc WSL để chạy .sh files
2. **SSH Keys**: Sẽ được tạo trong Git Bash environment
3. **Ansible**: Chạy tốt nhất trên WSL hoặc Git Bash
4. **PowerShell**: Có thể dùng cho Vagrant nhưng hạn chế cho Ansible

## 🔍 Troubleshooting

### Lỗi Permission
- Chạy PowerShell/Git Bash as Administrator

### Lỗi SSH
```bash
# Trong Git Bash
ssh-keygen -t ed25519 -f ~/.ssh/ansible_key -N ""
```

### Lỗi Vagrant
```powershell
vagrant reload        # Restart
vagrant destroy -f    # Xóa và tạo lại
``` 