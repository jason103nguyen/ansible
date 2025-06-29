# 🚀 Môi Trường Thực Hành Ansible

Đây là môi trường thực hành hoàn chỉnh cho chuỗi "Bắt đầu với Ansible", được thiết kế để bạn có thể thực hành tất cả các kiến thức Ansible cơ bản.

## 📋 Cấu Trúc Thư Mục

```
ansible_lab/
├── Vagrantfile                 # Cấu hình 3 VM Ubuntu
├── ansible.cfg                 # Cấu hình Ansible
├── inventory                   # File inventory
├── bootstrap.yml               # Playbook bootstrap
├── site.yml                    # Playbook chính
├── test-playbook.yml          # Playbook test
├── group_vars/                 # Biến cho nhóm
│   ├── all.yml
│   ├── web_servers.yml
│   └── db_servers.yml
├── host_vars/                  # Biến cho từng host
│   ├── node1.yml
│   ├── node2.yml
│   └── node3.yml
├── roles/                      # Ansible roles
│   ├── base/
│   ├── webserver/
│   ├── database/
│   └── fileserver/
├── templates/                  # Templates
│   └── test-file.j2
└── scripts/                    # Helper scripts
    ├── setup-ssh-keys.sh
    ├── copy-keys.sh
    ├── vagrant-commands.sh
    └── ansible-commands.sh
```

## 🔧 Thiết Lập Ban Đầu

### 1. Khởi động các VM

```bash
# Khởi động tất cả VM
vagrant up

# Hoặc sử dụng script helper
bash scripts/vagrant-commands.sh start
```

### 2. Thiết lập SSH Keys

```bash
# Tạo SSH keys cho Ansible
bash scripts/setup-ssh-keys.sh

# Copy keys lên các VM (sau khi VM đã chạy)
bash scripts/copy-keys.sh
```

### 3. Test kết nối

```bash
# Test ping
ansible all -m ping

# Hoặc sử dụng script helper
bash scripts/ansible-commands.sh ping
```

## 🎯 Thực Hành Từng Chủ Đề

### 1. Lệnh Ad-hoc

```bash
# Test kết nối
ansible all -m ping

# Thu thập facts
ansible all -m gather_facts

# Kiểm tra uptime
ansible all -a "uptime"

# Cài đặt package
ansible all -m apt -a "name=htop state=latest" --become

# Quản lý service
ansible all -m service -a "name=ssh state=started" --become
```

### 2. Inventory và Groups

```bash
# Liệt kê tất cả hosts
ansible all --list-hosts

# Liệt kê hosts trong group
ansible web_servers --list-hosts

# Chạy lệnh chỉ trên một group
ansible web_servers -m ping

# Giới hạn lệnh trên một host
ansible all -m ping --limit node1
```

### 3. Variables và Facts

```bash
# Xem biến của một host
ansible node1 -m debug -a "var=hostvars[inventory_hostname]"

# Xem facts
ansible node1 -m setup

# Sử dụng biến trong ad-hoc
ansible web_servers -m debug -a "msg='Server role: {{ server_role }}'"
```

### 4. Playbooks

```bash
# Chạy test playbook
ansible-playbook test-playbook.yml

# Chạy với tags cụ thể
ansible-playbook test-playbook.yml --tags connectivity

# Dry run (kiểm tra không thực thi)
ansible-playbook site.yml --check

# Verbose mode
ansible-playbook site.yml -v
```

### 5. Roles

```bash
# Chạy site playbook (sử dụng roles)
ansible-playbook site.yml

# Chạy chỉ web servers
ansible-playbook site.yml --tags web

# Chạy chỉ database servers
ansible-playbook site.yml --tags db
```

### 6. Templates và Handlers

```bash
# Chạy playbook có sử dụng templates
ansible-playbook site.yml

# Kiểm tra file được tạo từ template
ansible all -a "cat /tmp/ansible-test.txt"
```

### 7. Conditions (When)

Templates đã bao gồm các điều kiện `when` dựa trên:
- `ansible_os_family`
- `inventory_hostname`
- Group membership

## 🛠️ Scripts Helper

### Vagrant Commands

```bash
bash scripts/vagrant-commands.sh start      # Khởi động VM
bash scripts/vagrant-commands.sh stop       # Dừng VM
bash scripts/vagrant-commands.sh status     # Xem trạng thái
bash scripts/vagrant-commands.sh ssh1       # SSH vào node1
```

### Ansible Commands

```bash
bash scripts/ansible-commands.sh ping       # Test ping
bash scripts/ansible-commands.sh facts      # Thu thập facts
bash scripts/ansible-commands.sh uptime     # Xem uptime
bash scripts/ansible-commands.sh install htop # Cài package
bash scripts/ansible-commands.sh bootstrap  # Chạy bootstrap
bash scripts/ansible-commands.sh site       # Chạy site playbook
```

## 🧪 Các Bài Tập Thực Hành

### Bài 1: Lệnh Ad-hoc Cơ Bản
1. Test ping tất cả servers
2. Thu thập facts từ node1
3. Kiểm tra disk space trên tất cả servers
4. Cài đặt package `tree` trên tất cả servers

### Bài 2: Inventory và Groups
1. Liệt kê tất cả hosts trong group `web_servers`
2. Chạy lệnh chỉ trên `db_servers`
3. Sử dụng `--limit` để chạy lệnh chỉ trên node2

### Bài 3: Playbooks và Variables
1. Chạy `test-playbook.yml`
2. Xem các biến được định nghĩa cho node1
3. Chỉnh sửa biến `custom_message` cho node2

### Bài 4: Roles và Tags
1. Chạy `site.yml` với tag `base`
2. Chạy chỉ web server configuration
3. Kiểm tra trang web trên node1 và node2

### Bài 5: Templates và Handlers
1. Chỉnh sửa template `index.html.j2`
2. Chạy lại playbook và xem thay đổi
3. Kiểm tra Apache được restart tự động

## 🌐 Truy Cập Các Dịch Vụ

Sau khi chạy `site.yml`:

- **Web Servers**: 
  - http://192.168.56.101 (node1 - có PHP)
  - http://192.168.56.102 (node2)
- **Database**: 192.168.56.103:3306
- **File Share**: \\192.168.56.101\shared

## 🔧 Troubleshooting

### SSH Connection Issues
```bash
# Kiểm tra SSH key
ssh -i ~/.ssh/ansible_key vagrant@192.168.56.101

# Copy lại key nếu cần
ssh-copy-id -i ~/.ssh/ansible_key.pub vagrant@192.168.56.101
```

### Permission Issues
```bash
# Chạy với sudo
ansible-playbook bootstrap.yml --ask-become-pass
```

### VM Issues
```bash
# Restart VM
vagrant reload

# Destroy và tạo lại
vagrant destroy -f && vagrant up
```

## 📚 Kiến Thức Được Thực Hành

✅ **SSH và Key Management**
✅ **Inventory và Groups** 
✅ **Ad-hoc Commands**
✅ **Playbooks và YAML**
✅ **Variables và Facts**
✅ **Conditions (when)**
✅ **Roles và Organization**
✅ **Templates (Jinja2)**
✅ **Handlers**
✅ **Tags**
✅ **File Management**
✅ **Service Management**
✅ **Package Management**
✅ **User Management**
✅ **Git Integration**

Chúc bạn thực hành vui vẻ! 🎉 