# ⚡ Quick Start - Bắt Đầu Nhanh

## 🚀 5 Phút Đầu Tiên

### 1. Khởi động VM
```bash
vagrant up
```

### 2. Setup SSH (Git Bash/WSL)
```bash
bash scripts/setup-ssh-keys.sh
bash scripts/copy-keys.sh
```

### 3. Test Ansible
```bash
ansible all -m ping
```

### 4. Chạy Playbook Đầu Tiên
```bash
ansible-playbook test-playbook.yml
```

### 5. Deploy Full Stack
```bash
ansible-playbook site.yml
```

## 🌐 Kiểm Tra Kết Quả

- Web Server: http://192.168.56.101 và http://192.168.56.102
- SSH vào VM: `vagrant ssh node1`

## 📚 Tiếp Theo

Đọc [README.md](README.md) để hiểu chi tiết về từng component.

## ❗ Nếu Gặp Lỗi

1. **SSH lỗi**: Chạy lại `bash scripts/copy-keys.sh`
2. **VM lỗi**: `vagrant reload`
3. **Ansible lỗi**: Kiểm tra file `inventory` và `ansible.cfg`

Chúc thực hành vui vẻ! 🎉 