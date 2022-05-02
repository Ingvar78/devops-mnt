# Самоконтроль выполненения задания

1. Где расположен файл с `some_fact` из второго пункта задания?
Файл располагается в диреткории group_vars/all/examp.yml
2. Какая команда нужна для запуска вашего `playbook` на окружении `test.yml`?

```
iva@c8n:~/8x/playbook $ ansible-playbook site.yml -i inventory/test.yml 
```
3. Какой командой можно зашифровать файл?

```bash
iva@c8n:~/8x/playbook $ ansible-vault encrypt group_vars/el/examp.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
New Vault password: 
Confirm New Vault password: 
Encryption successful
```

4. Какой командой можно расшифровать файл?

```bash
iva@c8n:~/8x/playbook $ ansible-vault decrypt group_vars/el/examp.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
Vault password: 
Decryption successful
```

5. Можно ли посмотреть содержимое зашифрованного файла без команды расшифровки файла? Если можно, то как?

```bash
iva@c8n:~/8x/playbook $ ansible-vault view group_vars/el/examp.yml 
[DEPRECATION WARNING]: Ansible will require Python 3.8 or newer on the controller starting with Ansible 2.12. Current version: 3.6.8 (default, Mar 25 2022, 11:15:52) [GCC 8.5.0 20210514 (Red Hat 8.5.0-10)]. 
This feature will be removed from ansible-core in version 2.12. Deprecation warnings can be disabled by setting deprecation_warnings=False in ansible.cfg.
Vault password: 
---
  some_fact: "el default fact"

```

6. Как выглядит команда запуска `playbook`, если переменные зашифрованы?

ansible-playbook site.yml -i inventory/prod.yml --ask-vault-password

7. Как называется модуль подключения к host на windows?

для Windows есть  два модуля, winrm и psprp:

psrp                           Run tasks over Microsoft PowerShell Remoting Protocol 
winrm                          Run tasks over Microsoft's WinRM 

8. Приведите полный текст команды для поиска информации в документации ansible для модуля подключений ssh

ansible-doc -t connection ssh

9. Какой параметр из модуля подключения `ssh` необходим для того, чтобы определить пользователя, под которым необходимо совершать подключение?

```
- remote_user
        User name with which to login to the remote server, normally set by the remote_user keyword.
        If no user is supplied, Ansible will let the ssh client binary choose the user as it normally
        [Default: (null)]
        set_via:
          env:
          - name: ANSIBLE_REMOTE_USER
          ini:
          - key: remote_user
            section: defaults
          vars:
          - name: ansible_user
          - name: ansible_ssh_user
        
        cli:
        - name: user
        

```
