# ⚡ Quick Start - Getting Started Fast

## 🚀 First 5 Minutes

### 1. Start VMs
```bash
vagrant up
```

### 2. Setup SSH Keys
```bash
bash scripts/setup-ssh-keys.sh
bash scripts/copy-keys-vagrant.sh
```

### 3. Test Connection
```bash
ansible all -m ping
```

### 4. Run First Playbook
```bash
ansible-playbook test-playbook.yml
```

### 5. Deploy Full Environment
```bash
ansible-playbook site.yml
```

## 🌐 Check Results

- Web Server: http://192.168.56.101 and http://192.168.56.102
- SSH to VM: `vagrant ssh node1`

## 📚 Next Steps

Read [README.md](README.md) to understand each component in detail.

## ❗ If You Encounter Errors

1. **SSH errors**: Re-run `bash scripts/copy-keys.sh`
2. **VM errors**: `vagrant reload`
3. **Ansible errors**: Check `inventory` and `ansible.cfg` files

Happy practicing! 🎉 