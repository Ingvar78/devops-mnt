# Домашнее задание к занятию "08.02 Работа с Playbook"

## Подготовка к выполнению

1. Создайте свой собственный (или используйте старый) публичный репозиторий на github с произвольным именем.
2. Скачайте [playbook](./playbook/) из репозитория с домашним заданием и перенесите его в свой репозиторий.
3. Подготовьте хосты в соответствии с группами из предподготовленного playbook.

## Основная часть

1. Приготовьте свой собственный inventory файл `prod.yml`.

```bash
va@c9:~/Documents/08-ansible/08-2  (08.2 *)$ cat inventory/prod.yml 
---
clickhouse:
  hosts:
    clickhouse-01:
      ansible_host: 192.168.1.41
vector:
  hosts:
    vector-01:
      ansible_host: 192.168.1.41
    vector-02:
      ansible_host: 192.168.1.42
```

2. Допишите playbook: нужно сделать ещё один play, который устанавливает и настраивает [vector](https://vector.dev).
3. При создании tasks рекомендую использовать модули: `get_url`, `template`, `unarchive`, `file`.
4. Tasks должны: скачать нужной версии дистрибутив, выполнить распаковку в выбранную директорию, установить vector.

```
- name: Install Vector
  hosts: vector
  handlers:
    - name: Start vector service
      become: true
      ansible.builtin.service:
        name: vector
        state: restarted
  tasks:
    - name: Get vectore distrib
      ansible.builtin.get_url:
        url: https://packages.timber.io/vector/{{ vector_version }}/vector-{{ vector_version }}-1.x86_64.rpm
        dest: ./vector-{{ vector_version }}-1.x86_64.rpm
        mode: 0755
    - name: Install vectore rpm
      become: true
      ansible.builtin.yum:
        name: vector-{{ vector_version }}-1.x86_64.rpm
        disable_gpg_check: true
      notify: Start vector service
```

5. Запустите `ansible-lint site.yml` и исправьте ошибки, если они есть.

На этапе отладки скрипта обнаруженные ошибки были исправлены:
    1) mode: 0755
    2) disable_gpg_check: true

6. Попробуйте запустить playbook на этом окружении с флагом `--check`.

При первом запуске с параметром '--check' выполнение playbook вызовет ошибку, т.к. на целевых хостах не будет скачано ни одного дистрибутива.
Как вариант вначале можно выполнить загрузку дистрибутивов а затем произвести выполнение с '--check' либо выполнить в режиме отладки

<details>
     <summary>Пример ошибки при первом запуске</summary>
    <br>

```
fatal: [clickhouse-01]: FAILED! => {
    "changed": false,
    "module_stderr": "Shared connection to 192.168.1.41 closed.\r\n",
    "module_stdout": "Traceback (most recent call last):\r\n  File \"/home/iva/.ansible/tmp/ansible-tmp-1652047587.644661-83268-60172319615127/AnsiballZ_dnf.py\", line 107, in <module>\r\n    _ansiballz_main()\r\n  File \"/home/iva/.ansible/tmp/ansible-tmp-1652047587.644661-83268-60172319615127/AnsiballZ_dnf.py\", line 99, in _ansiballz_main\r\n    invoke_module(zipped_mod, temp_path, ANSIBALLZ_PARAMS)\r\n  File \"/home/iva/.ansible/tmp/ansible-tmp-1652047587.644661-83268-60172319615127/AnsiballZ_dnf.py\", line 48, in invoke_module\r\n    run_name='__main__', alter_sys=True)\r\n  File \"/usr/lib64/python3.6/runpy.py\", line 205, in run_module\r\n    return _run_module_code(code, init_globals, run_name, mod_spec)\r\n  File \"/usr/lib64/python3.6/runpy.py\", line 96, in _run_module_code\r\n    mod_name, mod_spec, pkg_name, script_name)\r\n  File \"/usr/lib64/python3.6/runpy.py\", line 85, in _run_code\r\n    exec(code, run_globals)\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_t_03fb_2/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1427, in <module>\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_t_03fb_2/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1416, in main\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_t_03fb_2/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1390, in run\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_t_03fb_2/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 1048, in ensure\r\n  File \"/tmp/ansible_ansible.legacy.dnf_payload_t_03fb_2/ansible_ansible.legacy.dnf_payload.zip/ansible/modules/dnf.py\", line 948, in _install_remote_rpms\r\n  File \"/usr/lib/python3.6/site-packages/dnf/base.py\", line 1271, in add_remote_rpms\r\n    raise IOError(_(\"Could not open: {}\").format(' '.join(pkgs_error)))\r\nOSError: Could not open: clickhouse-common-static-22.4.4.7.rpm clickhouse-client-22.4.4.7.rpm clickhouse-server-22.4.4.7.rpm\r\n",
    "msg": "MODULE FAILURE\nSee stdout/stderr for the exact error",
    "rc": 1
}

PLAY RECAP *********************************************************************
clickhouse-01              : ok=2    changed=1    unreachable=0    failed=1    skipped=0    rescued=1    ignored=0   

```

</details>


<details>
     <summary>Результат применения playbook</summary>
    <br>


```
iva@c9:~/Documents/08-ansible/08-2  (08.2 *)$ ansible-playbook site.yml -i inventory/prod.yml 

PLAY [Install Clickhouse] ***********************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.4.4.7.rpm", "elapsed": 0, "gid": 1000, "group": "iva", "item": "clickhouse-common-static", "mode": "0755", "msg": "Request failed", "owner": "iva", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 251606890, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.4.4.7.noarch.rpm"}

TASK [Get clickhouse distrib] *******************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] **************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ***************************************************************************************************************************************************************************************************************************************************************

TASK [Create database] **************************************************************************************************************************************************************************************************************************************************************
changed: [clickhouse-01]

PLAY [Install Vector] ***************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************************************************************************************
ok: [vector-01]
ok: [vector-02]

TASK [Get vectore distrib] **********************************************************************************************************************************************************************************************************************************************************
changed: [vector-02]
changed: [vector-01]

TASK [Install vectore rpm] **********************************************************************************************************************************************************************************************************************************************************
changed: [vector-02]
changed: [vector-01]

RUNNING HANDLER [Start vector service] **********************************************************************************************************************************************************************************************************************************************
changed: [vector-02]
changed: [vector-01]

PLAY RECAP **************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=1    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-02                  : ok=4    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

</details>

7. Запустите playbook на `prod.yml` окружении с флагом `--diff`. Убедитесь, что изменения на системе произведены.

<details>
     <summary>Пример повторного выполнения с '--diff'</summary>
    <br>


```
iva@c9:~/Documents/08-ansible/08-2  (08.2 *)$ ansible-playbook site.yml -i inventory/prod.yml --diff

PLAY [Install Clickhouse] ***********************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Get clickhouse distrib] *******************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01] => (item=clickhouse-client)
ok: [clickhouse-01] => (item=clickhouse-server)
failed: [clickhouse-01] (item=clickhouse-common-static) => {"ansible_loop_var": "item", "changed": false, "dest": "./clickhouse-common-static-22.4.4.7.rpm", "elapsed": 0, "gid": 1000, "group": "iva", "item": "clickhouse-common-static", "mode": "0755", "msg": "Request failed", "owner": "iva", "response": "HTTP Error 404: Not Found", "secontext": "unconfined_u:object_r:user_home_t:s0", "size": 251606890, "state": "file", "status_code": 404, "uid": 1000, "url": "https://packages.clickhouse.com/rpm/stable/clickhouse-common-static-22.4.4.7.noarch.rpm"}

TASK [Get clickhouse distrib] *******************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Install clickhouse packages] **************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

TASK [Flush handlers] ***************************************************************************************************************************************************************************************************************************************************************

TASK [Create database] **************************************************************************************************************************************************************************************************************************************************************
ok: [clickhouse-01]

PLAY [Install Vector] ***************************************************************************************************************************************************************************************************************************************************************

TASK [Gathering Facts] **************************************************************************************************************************************************************************************************************************************************************
ok: [vector-01]
ok: [vector-02]

TASK [Get vectore distrib] **********************************************************************************************************************************************************************************************************************************************************
ok: [vector-02]
ok: [vector-01]

TASK [Install vectore rpm] **********************************************************************************************************************************************************************************************************************************************************
ok: [vector-02]
ok: [vector-01]

PLAY RECAP **************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-02                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```
</details>

8. Повторно запустите playbook с флагом `--diff` и убедитесь, что playbook идемпотентен.

```
PLAY RECAP **************************************************************************************************************************************************************************************************************************************************************************
clickhouse-01              : ok=4    changed=0    unreachable=0    failed=0    skipped=0    rescued=1    ignored=0   
vector-01                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
vector-02                  : ok=3    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

9. Подготовьте README.md файл по своему playbook. В нём должно быть описано: что делает playbook, какие у него есть параметры и теги.
10. Готовый playbook выложите в свой репозиторий, поставьте тег `08-ansible-02-playbook` на фиксирующий коммит, в ответ предоставьте ссылку на него.

[08-ansible-02-playbook](https://github.com/Ingvar78/08-ansible/tree/08.2/08-2)

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
