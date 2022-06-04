# Домашнее задание к занятию "08.05 Тестирование Roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.4.0"`
2. Соберите локальный образ на основе [Dockerfile](./Dockerfile)

## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos7` внутри корневой директории clickhouse-role, посмотрите на вывод команды.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it <image_name> /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
4. Добавьте файл `tox.ini` в корень репозитория каждой своей роли.
5. Создайте облегчённый сценарий для `molecule`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.
7. Запустите `docker` контейнер так, чтобы внутри оказались обе ваши роли.
8. Зайдти поочерёдно в каждую из них и запустите команду `tox`. Убедитесь, что всё отработало успешно.
9. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

После выполнения у вас должно получится два сценария molecule и один tox.ini файл в репозитории. Ссылка на репозиторий являются ответами на домашнее задание. Не забудьте указать в ответе теги решений Tox и Molecule заданий.

## Необязательная часть

1. Проделайте схожие манипуляции для создания роли lighthouse.
2. Создайте сценарий внутри любой из своих ролей, который умеет поднимать весь стек при помощи всех ролей.
3. Убедитесь в работоспособности своего стека. Создайте отдельный verify.yml, который будет проверять работоспособность интеграции всех инструментов между ними.
4. Выложите свои roles в репозитории. В ответ приведите ссылки.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---

<details>
     <summary>Решение Задачи *</summary>
    <br>

```bash
iva@u22adm:~/DAM/clickhouse-role/roles/clickhouse$ docker --version && ansible --version && ansible-lint --version && molecule --version
Docker version 20.10.16, build aa7e414
ansible [core 2.12.6]
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/iva/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3/dist-packages/ansible
  ansible collection location = /home/iva/.ansible/collections:/usr/share/ansible/collections
  executable location = /usr/bin/ansible
  python version = 3.10.4 (main, Apr  2 2022, 09:04:19) [GCC 11.2.0]
  jinja version = 3.0.3
  libyaml = True
ansible-lint 5.4.0 using ansible 2.12.6
molecule 3.4.0 using python 3.10 
    ansible:2.12.6
    delegated:3.4.0 from molecule
    docker:1.1.0 from molecule_docker requiring collections: community.docker>=1.9.1
```

```bash
iva@u22adm:~/DAM/clickhouse-role/roles/clickhouse$ molecule test -s centos_7
INFO     centos_7 scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Guessed /home/iva/DAM/clickhouse-role as project root directory
INFO     Using /home/iva/.cache/ansible-lint/8fee5b/roles/alexeysetevoi.clickhouse symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/home/iva/.cache/ansible-lint/8fee5b/roles
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > dependency
INFO     Running ansible-galaxy collection install --force -v community.docker:>=1.9.1
ERROR    Command returned 250 code:
[0;34mUsing /etc/ansible/ansible.cfg as config file[0m
Starting galaxy collection install process
Process install dependency map
[0;31mERROR! Unexpected Exception, this is probably a bug: CollectionDependencyProvider.find_matches() got an unexpected keyword argument 'identifier'[0m
to see the full traceback, use -vvv

WARNING  An error occurred during the test sequence action: 'dependency'. Cleaning up.
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/hosts.yml linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/hosts
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/group_vars/ linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/group_vars
INFO     Inventory /home/iva/DAM/clickhouse-role/roles/clickhouse/molecule/centos_7/../resources/inventory/host_vars/ linked to /home/iva/.cache/molecule/clickhouse/centos_7/inventory/host_vars
INFO     Running centos_7 > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=centos_7)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=centos_7)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
iva@u22adm:~/DAM/clickhouse-role/roles/clickhouse$ 
```

```bash
iva@u22adm:~/DAM/vector-role$ molecule init scenario --driver-name docker
INFO     Initializing new scenario default...
INFO     Initialized scenario in /home/iva/DAM/vector-role/molecule/default successfully.
iva@u22adm:~/DAM/vector-role$ 
```

```bash
iva@u22adm:~/DAM/vector-role$ molecule test
INFO     default scenario test matrix: dependency, lint, cleanup, destroy, syntax, create, prepare, converge, idempotence, side_effect, verify, cleanup, destroy
INFO     Performing prerun...
INFO     Guessed /home/iva/DAM/vector-role as project root directory
WARNING  Computed fully qualified role name of vector does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

INFO     Using /home/iva/.cache/ansible-lint/cc2f6a/roles/vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/home/iva/.cache/ansible-lint/cc2f6a/roles
INFO     Running default > dependency
INFO     Running ansible-galaxy collection install --force -v community.docker:>=1.9.1
ERROR    Command returned 250 code:
[0;34mUsing /etc/ansible/ansible.cfg as config file[0m
Starting galaxy collection install process
Process install dependency map
[0;31mERROR! Unexpected Exception, this is probably a bug: CollectionDependencyProvider.find_matches() got an unexpected keyword argument 'identifier'[0m
to see the full traceback, use -vvv

WARNING  An error occurred during the test sequence action: 'dependency'. Cleaning up.
INFO     Running default > cleanup
WARNING  Skipping, cleanup playbook not configured.
INFO     Running default > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
iva@u22adm:~/DAM/vector-role$ 

```

```bash
iva@u22adm:~/DAM/vector-role$ molecule init scenario ubuntu_latest --driver-name docker
INFO     Initializing new scenario ubuntu_latest...
INFO     Initialized scenario in /home/iva/DAM/vector-role/molecule/ubuntu_latest successfully.
iva@u22adm:~/DAM/vector-role$ 

```

</detail>


<details>
     <summary>Решение Задачи *</summary>
    <br>

</detail>
