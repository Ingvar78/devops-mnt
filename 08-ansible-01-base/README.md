# Домашнее задание к занятию "08.01 Введение в Ansible"

## Подготовка к выполнению
1. Установите ansible версии 2.10 или выше.

```bash
 iva@c8n:~/8x/playbook $ ansible --version
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. This feature will be removed from ansible-core in version 2.12. 
Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ansible [core 2.11.7] 
  config file = None
  configured module search path = ['/home/iva/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/iva/.local/lib/python3.6/site-packages/ansible
  ansible collection location = /home/iva/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/iva/.local/bin/ansible
  python version = 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]
  jinja version = 3.0.3
  libyaml = True
iva@c8n:~/8x/playbook $ 

```

2. Создайте свой собственный публичный репозиторий на github с произвольным именем.
3. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.

## Основная часть
1. Попробуйте запустить playbook на окружении из `test.yml`, зафиксируйте какое значение имеет факт `some_fact` для указанного хоста при выполнении playbook'a.

```bash
iva@c8n:~/8x/playbook $ ansible-playbook site.yml -i inventory/test.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": 12
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

2. Найдите файл с переменными (group_vars) в котором задаётся найденное в первом пункте значение и поменяйте его на 'all default fact'.

```bash
iva@c8n:~/8x/playbook $ ansible-playbook site.yml -i inventory/test.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

3. Воспользуйтесь подготовленным (используется `docker`) или создайте собственное окружение для проведения дальнейших испытаний.

```bash
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [centos8]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host ubuntu should use /usr/bin/python3, but is using /usr/bin/python for backward compatibility with prior Ansible releases. A future Ansible release will 
default to using the discovered platform python for this host. See https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed 
in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [ubuntu]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [centos8] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [centos8] => {
    "msg": "el"
}
ok: [ubuntu] => {
    "msg": "deb"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```


4. Проведите запуск playbook на окружении из `prod.yml`. Зафиксируйте полученные значения `some_fact` для каждого из `managed host`.
5. Добавьте факты в `group_vars` каждой из групп хостов так, чтобы для `some_fact` получились следующие значения: для `deb` - 'deb default fact', для `el` - 'el default fact'.

```bash
DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [centos8]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host ubuntu should use /usr/bin/python3, but is using /usr/bin/python for backward compatibility with prior Ansible releases. A future Ansible release will 
default to using the discovered platform python for this host. See https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed 
in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [ubuntu]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [centos8] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [centos8] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

6.  Повторите запуск playbook на окружении `prod.yml`. Убедитесь, что выдаются корректные значения для всех хостов.
7. При помощи `ansible-vault` зашифруйте факты в `group_vars/deb` и `group_vars/el` с паролем `netology`.

```bash
 iva@c8n:~/8x/playbook $ ansible-vault encrypt group_vars/deb/examp.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
New Vault password: 
Confirm New Vault password: 
Encryption successful
iva@c8n:~/8x/playbook $ ansible-vault encrypt group_vars/el/examp.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
New Vault password: 
Confirm New Vault password: 
Encryption successful
```

```bash
iva@c8n:~/8x/playbook $ ansible-playbook site.yml -i inventory/prod.yml --ask-vault-password

DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
Vault password: 

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [centos8]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host ubuntu should use /usr/bin/python3, but is using /usr/bin/python for backward compatibility with prior Ansible releases. A future Ansible release will 
default to using the discovered platform python for this host. See https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed 
in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [ubuntu]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [centos8] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [centos8] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

8. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь в работоспособности.

9. Посмотрите при помощи `ansible-doc` список плагинов для подключения. Выберите подходящий для работы на `control node`.

```bash
iva@c8n:~/8x/playbook $ ansible-doc -t connection -l
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
[WARNING]: Collection frr.frr does not support Ansible version 2.11.7
[WARNING]: Collection ibm.qradar does not support Ansible version 2.11.7
[WARNING]: Collection splunk.es does not support Ansible version 2.11.7
ansible.netcommon.httpapi      Use httpapi to run command on network appliances                                                                                                                               
ansible.netcommon.libssh       (Tech preview) Run tasks using libssh for ssh connection                                                                                                                       
ansible.netcommon.napalm       Provides persistent connection using NAPALM                                                                                                                                    
ansible.netcommon.netconf      Provides a persistent connection using the netconf protocol                                                                                                                    
ansible.netcommon.network_cli  Use network_cli to run command on network appliances                                                                                                                           
ansible.netcommon.persistent   Use a persistent unix socket for connection                                                                                                                                    
community.aws.aws_ssm          execute via AWS Systems Manager                                                                                                                                                
community.docker.docker        Run tasks in docker containers                                                                                                                                                 
community.docker.docker_api    Run tasks in docker containers                                                                                                                                                 
community.docker.nsenter       execute on host running controller container                                                                                                                                   
community.general.chroot       Interact with local chroot                                                                                                                                                     
community.general.funcd        Use funcd to connect to target                                                                                                                                                 
community.general.iocage       Run tasks in iocage jails                                                                                                                                                      
community.general.jail         Run tasks in jails                                                                                                                                                             
community.general.lxc          Run tasks in lxc containers via lxc python library                                                                                                                             
community.general.lxd          Run tasks in lxc containers via lxc CLI                                                                                                                                        
community.general.qubes        Interact with an existing QubesOS AppVM                                                                                                                                        
community.general.saltstack    Allow ansible to piggyback on salt minions                                                                                                                                     
community.general.zone         Run tasks in a zone instance                                                                                                                                                   
community.kubernetes.kubectl   Execute tasks in pods running on Kubernetes                                                                                                                                    
community.libvirt.libvirt_lxc  Run tasks in lxc containers via libvirt                                                                                                                                        
community.libvirt.libvirt_qemu Run tasks on libvirt/qemu virtual machines                                                                                                                                     
community.okd.oc               Execute tasks in pods running on OpenShift                                                                                                                                     
community.vmware.vmware_tools  Execute tasks inside a VM via VMware Tools                                                                                                                                     
containers.podman.buildah      Interact with an existing buildah container                                                                                                                                    
containers.podman.podman       Interact with an existing podman container                                                                                                                                     
kubernetes.core.kubectl        Execute tasks in pods running on Kubernetes                                                                                                                                    
local                          execute on controller                                                                                                                                                          
paramiko_ssh                   Run tasks via python ssh (paramiko)                                                                                                                                            
psrp                           Run tasks over Microsoft PowerShell Remoting Protocol                                                                                                                          
ssh                            connect via ssh client binary                                                                                                                                                  
winrm                          Run tasks over Microsoft's WinRM                  
```

Для localhost целесообразно использовть local

10. В `prod.yml` добавьте новую группу хостов с именем  `local`, в ней разместите localhost с необходимым типом подключения.

```bash
iva@c8n:~/8x/playbook $ cat inventory/prod.yml 
---
  el:
    hosts:
      centos8:
        ansible_connection: docker
  deb:
    hosts:
      ubuntu:
        ansible_connection: docker
  local:
    hosts:
      localhost:
        ansible_connection: local
iva@c8n:~/8x/playbook $ 

```

```bash
play ansible
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
Vault password: 

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]
ok: [centos8]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host ubuntu should use /usr/bin/python3, but is using /usr/bin/python for backward compatibility with prior Ansible releases. A future Ansible release will 
default to using the discovered platform python for this host. See https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed 
in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [ubuntu]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}
ok: [centos8] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "all default fact"
}
ok: [centos8] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```


11. Запустите playbook на окружении `prod.yml`. При запуске `ansible` должен запросить у вас пароль. Убедитесь что факты `some_fact` для каждого из хостов определены из верных `group_vars`.
12. Заполните `README.md` ответами на вопросы. Сделайте `git push` в ветку `master`. В ответе отправьте ссылку на ваш открытый репозиторий с изменённым `playbook` и заполненным `README.md`.

## Необязательная часть

1. При помощи `ansible-vault` расшифруйте все зашифрованные файлы с переменными.
2. Зашифруйте отдельное значение `PaSSw0rd` для переменной `some_fact` паролем `netology`. Добавьте полученное значение в `group_vars/all/exmp.yml`.

```bash
iva@c8n:~/8x/playbook $ ansible-vault encrypt group_vars/all/examp.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
New Vault password: 
Confirm New Vault password: 
Encryption successful

```

3. Запустите `playbook`, убедитесь, что для нужных хостов применился новый `fact`.

```bash
play ansible
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
Vault password: 

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]
ok: [centos8]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host ubuntu should use /usr/bin/python3, but is using /usr/bin/python for backward compatibility with prior Ansible releases. A future Ansible release will 
default to using the discovered platform python for this host. See https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed 
in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [ubuntu]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}
ok: [centos8] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [centos8] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```


4. Добавьте новую группу хостов `fedora`, самостоятельно придумайте для неё переменную. В качестве образа можно использовать [этот](https://hub.docker.com/r/pycontribs/fedora).

```bash
play ansible
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
Vault password: 

PLAY [Print os facts] *********************************************************************************************************************************************************************************************

TASK [Gathering Facts] ********************************************************************************************************************************************************************************************
ok: [localhost]
ok: [centos8]
ok: [fedora]
[DEPRECATION WARNING]: Distribution Ubuntu 18.04 on host ubuntu should use /usr/bin/python3, but is using /usr/bin/python for backward compatibility with prior Ansible releases. A future Ansible release will 
default to using the discovered platform python for this host. See https://docs.ansible.com/ansible-core/2.11/reference_appendices/interpreter_discovery.html for more information. This feature will be removed 
in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
ok: [ubuntu]

TASK [Print OS] ***************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "CentOS"
}
ok: [ubuntu] => {
    "msg": "Ubuntu"
}
ok: [centos8] => {
    "msg": "CentOS"
}
ok: [fedora] => {
    "msg": "Fedora"
}

TASK [Print fact] *************************************************************************************************************************************************************************************************
ok: [localhost] => {
    "msg": "PaSSw0rd"
}
ok: [centos8] => {
    "msg": "el default fact"
}
ok: [ubuntu] => {
    "msg": "deb default fact"
}
ok: [fedora] => {
    "msg": "fed default fact"
}

PLAY RECAP ********************************************************************************************************************************************************************************************************
centos8                    : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
fedora                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
localhost                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
ubuntu                     : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   

```

5. Напишите скрипт на bash: автоматизируйте поднятие необходимых контейнеров, запуск ansible-playbook и остановку контейнеров.



6. Все изменения должны быть зафиксированы и отправлены в вашей личный репозиторий.

[данные playbook](https://github.com/Ingvar78/08-ansible)


---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
