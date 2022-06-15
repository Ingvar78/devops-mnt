# образ приближенный к YC:
сборка с минимальным набором пакетов Centos 7
отключен FireWallD

```bash
sudo adduser ansible
sudo passwd ansible
sudo usermod -aG wheel ansible
```
ssh-copy-id ansible@X.Y.Z.W
ssh ansible@X.Y.Z.W

```bash
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo yum update
sudo yum install net-tools
sudo yum install python3-setuptools
sudo yum install python-setuptools
```