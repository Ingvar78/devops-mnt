```bash
sudo yum install epel-release
sudo yum install -y gcc python3-pip python3-devel openssl-devel python3-libselinux
sudo yum install ansible
ansible --version
python3 -m pip install molecule ansible-core
python3 -m pip remove molecule ansible-core
python3 -m pip install --upgrade --user setuptools
python3 -m pip install "molecule==3.4.0"

sudo yum update
sudo python3 -m pip install --upgrade pip
python3 -m pip install "molecule==3.4.0"
sudo pip3 install ansible
sudo pip3 install "ansible-lint<6.0.0"

history 
```

```bash
sudo yum install epel-release
sudo yum install -y gcc openssl-devel python3-pip python3-devel python3-libselinux python3-setuptools python-setuptools

alternate
sudo yum install -y yum-utils gcc openssl-devel python3-pip python3-devel python3-libselinux python3-setuptools python-setuptools

sudo yum update

---sudo yum install ansible

sudo python3 -m pip install --upgrade pip
sudo pip3 install ansible

python3 -m pip install --upgrade --user setuptools
python3 -m pip install "molecule==3.4.0"
molecule --version
sudo pip3 install "ansible-lint<6.0.0"
ansible-lint --version
sudo pip3 install molecule_docker

   19  ansible --version
   21  history 
   22  molecule 
   23  mkdir test
   24  ls -la
   25  cd test/
   26  ls -la
   27  git clone git@github.com:Ingvar78/vector-role.git
   28  cd vector-role/
   29  molecule test -s centos_7
   30  mc
   31  history 
```

```bash
sudo yum install -y yum-utils
sudo yum-config-manager     --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -aG docker $USER

   38  exit
   39  cd test/vector-role/
pip3 install "ansible-lint<6.0.0"

molecule test -s centos_7
   43  sudo yum install gcc openssl-devel bzip2-devel libffi-devel zlib-devel
   44  sudo su
   45  python3.8 --version
   46  molecule test -s centos_7
   47  sudo su
   48  history 


pip3 install "molecule<3.4.0"
pip3 install "ansible-lint<6.0.0"
pip3 install molecule_docker
pip3 install flake8
```

Centos 9
```bash
[ansible@c9a2 ~]$ history 
    1  echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
    2  echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
    3  exit
    4  echo "$USER ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
    5  exit
    6  sudo su
    7  sudo yum install -y gcc python3-pip python3-devel openssl-devel python3-libselinux
    8  exit
    9  history 
   10  sudo usermod -aG docker jenkins
   11  sudo usermod -aG docker $USER
   12  sudo reboot
   13  sudo pip3 install flake8
   14  exit
   15  sudo su
   16  mkdir test
   17  cd test/
   18  git clone git@github.com:Ingvar78/vector-role.git
   19  exit
   20  cd test/
   21  git@github.com:Ingvar78/vector-role.git
   22  git clone git@github.com:Ingvar78/vector-role.git
   23  cd vector-role/
   24  molecule test 
   25  sudo cat /home/jenkins/.ansible_async/660893251982.1846
   26  sudo su
   27  exit
   28  sudo su
   29  pip3 install "molecule==3.5.2" "molecule_docker" "ansible-lint<6.0.0"
   30  history | grep8
   31  history | grep 8
   32  sudo su
   33  exit
   34  sudo su
   35  exit
   36  sudo su
   37  exit
   38  ls -la
   39  cd test/
   40  cd vector-role/
   41  molecule test -s centos_7
   42  history 
   43  molecule --version
   44  pip3 install "molecule<3.5.2" "molecule_docker" "ansible-lint<6.0.0"
   45  molecule test -s centos_7
   46  pip3 install "molecule<3.5.0" "molecule_docker" "ansible-lint<6.0.0"
   47  molecule test -s centos_7
   48  git pull
   49  molecule test -s centos_7
   50  molecule --version
   51  pip3 install "molecule<3.4.0" "molecule_docker" "ansible-lint<6.0.0"
   52  molecule test -s centos_7
   53  exit
   54  history 

[root@c9a2 ansible]# history 
    1  systemctl status firewalld
    2  systemctl stop firewalld
    3  systemctl disable firewalld
    4  cat /etc/selinux/config 
    5  vi /etc/selinux/config 
    6  reboot
    7  docker images
    8  docker ps
    9  flake8
   10  exit
   11  ls -la sudo /home/jenkins/.ansible_async/
   12  ls -la sudo /home/jenkins/.ansible_async/110682954080.11820 
   13  ls -la sudo /home/jenkins/.ansible_async/437479697866.1900 
   14  cat /home/jenkins/.ansible_async/110682954080.11820 
   15  molecule test --help
   16  exit
   17  cat /home/jenkins/.ansible_async/811436885968.2640
   18  molecule --version
   19  exit
   20  history 
   21  exit
   22  cat /opt/jenkins_agent/workspace/vector-role/molecule/centos_7/molecule.yml 
   23  docker images
   24  docker images
   25  docker rmi $(docker images -q)
   26  docker rm $(docker ps -a -q)
   27  docker stop $(docker ps -a -q)
   28  docker rm $(docker ps -a -q)
   29  docker rmi $(docker images -q)
   30  docker images
   31  exit
   32  docker images
   33  netstat 
   34  dnf install net-tools
   35  netstat 
   36  docker ps
   37  docker ps
   38  docker ps
   39  docker ps
   40  docker inspect -f '{{.State.Pid}}' eecf9266f255
   41  sudo nsenter -t 6037 -n netstat
   42  sudo nsenter -t 6037 -n netstat
   43  docker exec -it eecf9266f255 netstat
   44  docker ps
   45  exit
   46  history 

```