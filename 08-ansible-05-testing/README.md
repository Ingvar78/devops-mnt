# Домашнее задание к занятию "08.05 Тестирование Roles"

## Подготовка к выполнению
1. Установите molecule: `pip3 install "molecule==3.4.0"`
2. Соберите локальный образ на основе [Dockerfile](./Dockerfile)

Предлагаемый к использованию Docker контейнер собран на Ubuntu 14.04. 
Cборка локального образа по предлагаемому [Dockerfile](./Dockerfile) не проходит ввиду отсутсвия поддержки части ключей apt и пакетов указанных в Dockerfile.
При выполнении работы будет использоваться образ на основе Centos (pycontribs/centos:7).

```bash
# cat /etc/*release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=14.04
DISTRIB_CODENAME=trusty
DISTRIB_DESCRIPTION="Ubuntu 14.04.3 LTS"
NAME="Ubuntu"
VERSION="14.04.3 LTS, Trusty Tahr"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 14.04.3 LTS"
VERSION_ID="14.04"
HOME_URL="http://www.ubuntu.com/"
SUPPORT_URL="http://help.ubuntu.com/"
BUG_REPORT_URL="http://bugs.launchpad.net/ubuntu/"
# apt -v
apt 1.0.1ubuntu2 for amd64 compiled on Aug  1 2015 19:20:48

```

## Основная часть

Наша основная цель - настроить тестирование наших ролей. Задача: сделать сценарии тестирования для vector. Ожидаемый результат: все сценарии успешно проходят тестирование ролей.

### Molecule

1. Запустите  `molecule test -s centos7` внутри корневой директории clickhouse-role, посмотрите на вывод команды.
2. Перейдите в каталог с ролью vector-role и создайте сценарий тестирования по умолчанию при помощи `molecule init scenario --driver-name docker`.
3. Добавьте несколько разных дистрибутивов (centos:8, ubuntu:latest) для инстансов и протестируйте роль, исправьте найденные ошибки, если они есть.
4. Добавьте несколько assert'ов в verify.yml файл для  проверки работоспособности vector-role (проверка, что конфиг валидный, проверка успешности запуска, etc). Запустите тестирование роли повторно и проверьте, что оно прошло успешно.
5. Добавьте новый тег на коммит с рабочим сценарием в соответствии с семантическим версионированием.

[vector-role with molecule](https://github.com/Ingvar78/vector-role/tree/1.1.1)

### Tox

1. Добавьте в директорию с vector-role файлы из [директории](./example)
2. Запустите `docker run --privileged=True -v <path_to_repo>:/opt/vector-role -w /opt/vector-role -it <image_name> /bin/bash`, где path_to_repo - путь до корня репозитория с vector-role на вашей файловой системе.
3. Внутри контейнера выполните команду `tox`, посмотрите на вывод.
5. Создайте облегчённый сценарий для `molecule`. Проверьте его на исполнимость.
6. Пропишите правильную команду в `tox.ini` для того чтобы запускался облегчённый сценарий.
8. Запустите команду `tox`. Убедитесь, что всё отработало успешно.
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
     <summary>Решение Задачи Molecule </summary>
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
     <summary>molecule test -s centos_7 </summary>
    <br>

```bash
iva@u22adm:~/DAM/vector-role  (08-ansible-05-testing *)$ molecule test -s centos_7
INFO     centos_7 scenario test matrix: destroy, create, converge, idempotence, verify, destroy
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
INFO     Running centos_7 > destroy
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

INFO     Running centos_7 > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}) 

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/centos:7) 

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '295900228852.107506', 'results_file': '/home/iva/.ansible_async/295900228852.107506', 'changed': True, 'item': {'image': 'docker.io/pycontribs/centos:7', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running centos_7 > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Vector | Get vector distrib | CentOS] **********************
changed: [instance]

TASK [vector-role : Vector | Install vector rpm | CentOS] **********************
changed: [instance]

TASK [vector-role : Add vector user to systemd-journal group | CentOS] *********
ok: [instance]

TASK [vector-role : Get Vector distrib | Ubuntu] *******************************
skipping: [instance]

TASK [vector-role : Create systemd unit Vector] ********************************
skipping: [instance]

TASK [vector-role : Install Vector packages | Ubuntu] **************************
skipping: [instance]

TASK [vector-role : Add vector user to systemd-journal group | Ubuntu] *********
skipping: [instance]

TASK [vector-role : Vector | Update vector config] *****************************
changed: [instance]

TASK [vector-role : Vector | Create vector config] *****************************
changed: [instance]

RUNNING HANDLER [vector-role : Start vector service | CentOS] ******************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=6    changed=4    unreachable=0    failed=0    skipped=5    rescued=0    ignored=0

INFO     Running centos_7 > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************

```

</detail>

<details>
     <summary>Решение Задачи Molecule -  Ubuntu</summary>
    <br>

```bash
iva@u22adm:~/DAM/vector-role  (08-ansible-05-testing *)$ molecule test -s ubuntu_l
INFO     ubuntu_l scenario test matrix: destroy, create, converge, idempotence, verify, destroy
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
INFO     Running ubuntu_l > destroy
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

INFO     Running ubuntu_l > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}) 

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest) 

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) creation to complete (300 retries left).
changed: [localhost] => (item={'failed': 0, 'started': 1, 'finished': 0, 'ansible_job_id': '147866115741.110885', 'results_file': '/home/iva/.ansible_async/147866115741.110885', 'changed': True, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running ubuntu_l > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Vector | Get vector distrib | CentOS] **********************
skipping: [instance]

TASK [vector-role : Vector | Install vector rpm | CentOS] **********************
skipping: [instance]

TASK [vector-role : Add vector user to systemd-journal group | CentOS] *********
skipping: [instance]

TASK [vector-role : Get Vector distrib | Ubuntu] *******************************
changed: [instance]

TASK [vector-role : Create systemd unit Vector] ********************************
changed: [instance]

TASK [vector-role : Install Vector packages | Ubuntu] **************************
changed: [instance]

TASK [vector-role : Add vector user to systemd-journal group | Ubuntu] *********
changed: [instance]

TASK [vector-role : Vector | Update vector config] *****************************
changed: [instance]

TASK [vector-role : Vector | Create vector config] *****************************
changed: [instance]

RUNNING HANDLER [vector-role : Start Vector service | Ubuntu] ******************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=7    changed=6    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running ubuntu_l > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Vector | Get vector distrib | CentOS] **********************
skipping: [instance]

TASK [vector-role : Vector | Install vector rpm | CentOS] **********************
skipping: [instance]

TASK [vector-role : Add vector user to systemd-journal group | CentOS] *********
skipping: [instance]

TASK [vector-role : Get Vector distrib | Ubuntu] *******************************
ok: [instance]

TASK [vector-role : Create systemd unit Vector] ********************************
ok: [instance]

TASK [vector-role : Install Vector packages | Ubuntu] **************************
ok: [instance]

TASK [vector-role : Add vector user to systemd-journal group | Ubuntu] *********
ok: [instance]

TASK [vector-role : Vector | Update vector config] *****************************
ok: [instance]

TASK [vector-role : Vector | Create vector config] *****************************
ok: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=7    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running ubuntu_l > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Get Vector version] ******************************************************
ok: [instance]

TASK [Assert Vector instalation] ***********************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validation Vector configuration] *****************************************
ok: [instance]

TASK [Assert Vector validate config] *******************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running ubuntu_l > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: [localhost]: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory

```

</detail>

<details>
     <summary>Решение Задачи TOX</summary>
    <br>
```bash
[root@9a3f365cb69c vector-role]# tox -e py37-ansible210
py37-ansible210 installed: ansible==2.10.7,ansible-base==2.10.17,ansible-compat==1.0.0,ansible-lint==5.4.0,arrow==1.2.2,bcrypt==3.2.2,binaryornot==0.4.4,bracex==2.3.post1,cached-property==1.5.2,Cerberus==1.3.2,certifi==2022.5.18.1,cffi==1.15.0,chardet==4.0.0,charset-normalizer==2.0.12,click==8.1.3,click-help-colors==0.9.1,commonmark==0.9.1,cookiecutter==2.1.1,cryptography==37.0.2,distro==1.7.0,docker==5.0.3,enrich==1.2.7,idna==3.3,importlib-metadata==4.11.4,Jinja2==3.1.2,jinja2-time==0.2.0,jmespath==1.0.0,lxml==4.9.0,MarkupSafe==2.1.1,molecule==3.4.0,molecule-docker==1.1.0,packaging==21.3,paramiko==2.11.0,pathspec==0.9.0,pluggy==0.13.1,pycparser==2.21,Pygments==2.12.0,PyNaCl==1.5.0,pyparsing==3.0.9,python-dateutil==2.8.2,python-slugify==6.1.2,PyYAML==5.4.1,requests==2.27.1,rich==12.4.4,ruamel.yaml==0.17.21,ruamel.yaml.clib==0.2.6,selinux==0.2.1,six==1.16.0,subprocess-tee==0.3.5,tenacity==8.0.1,text-unidecode==1.3,typing_extensions==4.2.0,urllib3==1.26.9,wcmatch==8.4,websocket-client==1.3.2,yamllint==1.26.3,zipp==3.8.0
py37-ansible210 run-test-pre: PYTHONHASHSEED='1070672135'
py37-ansible210 run-test: commands[0] | molecule test -s ubuntu_l --destroy always
INFO     ubuntu_l scenario test matrix: destroy, create, converge, idempotence, verify, destroy
INFO     Performing prerun...
INFO     Guessed /opt/vector-role as project root directory
WARNING  Computed fully qualified role name of vector does not follow current galaxy requirements.
Please edit meta/main.yml and assure we can correctly determine full role name:

galaxy_info:
role_name: my_name  # if absent directory name hosting role is used instead
namespace: my_galaxy_namespace  # if absent, author is used instead

Namespace: https://galaxy.ansible.com/docs/contributing/namespaces.html#galaxy-namespace-limitations
Role: https://galaxy.ansible.com/docs/contributing/creating_role.html#role-names

As an alternative, you can add 'role-name' to either skip_list or warn_list.

INFO     Using /root/.cache/ansible-lint/b984a4/roles/vector symlink to current repository in order to enable Ansible to find the role using its expected full name.
INFO     Added ANSIBLE_ROLES_PATH=~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles:/root/.cache/ansible-lint/b984a4/roles
INFO     Running ubuntu_l > destroy
INFO     Sanity checks: 'docker'

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
ok: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=1    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Running ubuntu_l > create

PLAY [Create] ******************************************************************

TASK [Log into a Docker registry] **********************************************
skipping: [localhost] => (item=None) 
skipping: [localhost]

TASK [Check presence of custom Dockerfiles] ************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True})

TASK [Create Dockerfiles from image names] *************************************
skipping: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}) 

TASK [Discover local Docker images] ********************************************
ok: [localhost] => (item={'changed': False, 'skipped': True, 'skip_reason': 'Conditional result was False', 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item', 'i': 0, 'ansible_index_var': 'i'})

TASK [Build an Ansible compatible image (new)] *********************************
skipping: [localhost] => (item=molecule_local/docker.io/pycontribs/ubuntu:latest) 

TASK [Create docker network(s)] ************************************************

TASK [Determine the CMD directives] ********************************************
ok: [localhost] => (item={'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True})

TASK [Create molecule instance(s)] *********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) creation to complete] *******************************
FAILED - RETRYING: Wait for instance(s) creation to complete (300 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (299 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (298 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (297 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (296 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (295 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (294 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (293 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (292 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (291 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (290 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (289 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (288 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (287 retries left).
FAILED - RETRYING: Wait for instance(s) creation to complete (286 retries left).
changed: [localhost] => (item={'started': 1, 'finished': 0, 'ansible_job_id': '146980479654.2582', 'results_file': '/root/.ansible_async/146980479654.2582', 'changed': True, 'failed': False, 'item': {'image': 'docker.io/pycontribs/ubuntu:latest', 'name': 'instance', 'pre_build_image': True}, 'ansible_loop_var': 'item'})

PLAY RECAP *********************************************************************
localhost                  : ok=5    changed=2    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running ubuntu_l > converge

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Vector | Get vector distrib | CentOS] **********************
skipping: [instance]

TASK [vector-role : Vector | Install vector rpm | CentOS] **********************
skipping: [instance]

TASK [vector-role : Add vector user to systemd-journal group | CentOS] *********
skipping: [instance]

TASK [vector-role : Get Vector distrib | Ubuntu] *******************************
changed: [instance]

TASK [vector-role : Create systemd unit Vector] ********************************
[WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
changed: [instance]

TASK [vector-role : Install Vector packages | Ubuntu] **************************
changed: [instance]

TASK [vector-role : Add vector user to systemd-journal group | Ubuntu] *********
changed: [instance]

TASK [vector-role : Vector | Update vector config] *****************************
changed: [instance]

TASK [vector-role : Vector | Create vector config] *****************************
changed: [instance]

RUNNING HANDLER [vector-role : Start Vector service | Ubuntu] ******************
skipping: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=7    changed=6    unreachable=0    failed=0    skipped=4    rescued=0    ignored=0

INFO     Running ubuntu_l > idempotence

PLAY [Converge] ****************************************************************

TASK [Gathering Facts] *********************************************************
ok: [instance]

TASK [Include vector-role] *****************************************************

TASK [vector-role : Vector | Get vector distrib | CentOS] **********************
skipping: [instance]

TASK [vector-role : Vector | Install vector rpm | CentOS] **********************
skipping: [instance]

TASK [vector-role : Add vector user to systemd-journal group | CentOS] *********
skipping: [instance]

TASK [vector-role : Get Vector distrib | Ubuntu] *******************************
ok: [instance]

TASK [vector-role : Create systemd unit Vector] ********************************
[WARNING]: The value "0" (type int) was converted to "'0'" (type string). If
this does not look like what you expect, quote the entire value to ensure it
does not change.
ok: [instance]

TASK [vector-role : Install Vector packages | Ubuntu] **************************
ok: [instance]

TASK [vector-role : Add vector user to systemd-journal group | Ubuntu] *********
ok: [instance]

TASK [vector-role : Vector | Update vector config] *****************************
ok: [instance]

TASK [vector-role : Vector | Create vector config] *****************************
ok: [instance]

PLAY RECAP *********************************************************************
instance                   : ok=7    changed=0    unreachable=0    failed=0    skipped=3    rescued=0    ignored=0

INFO     Idempotence completed successfully.
INFO     Running ubuntu_l > verify
INFO     Running Ansible Verifier

PLAY [Verify] ******************************************************************

TASK [Example assertion] *******************************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Get Vector version] ******************************************************
ok: [instance]

TASK [Assert Vector instalation] ***********************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

TASK [Validation Vector configuration] *****************************************
ok: [instance]

TASK [Assert Vector validate config] *******************************************
ok: [instance] => {
    "changed": false,
    "msg": "All assertions passed"
}

PLAY RECAP *********************************************************************
instance                   : ok=5    changed=0    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

INFO     Verifier completed successfully.
INFO     Running ubuntu_l > destroy

PLAY [Destroy] *****************************************************************

TASK [Destroy molecule instance(s)] ********************************************
changed: [localhost] => (item=instance)

TASK [Wait for instance(s) deletion to complete] *******************************
FAILED - RETRYING: Wait for instance(s) deletion to complete (300 retries left).
changed: [localhost] => (item=instance)

TASK [Delete docker networks(s)] ***********************************************

PLAY RECAP *********************************************************************
localhost                  : ok=2    changed=2    unreachable=0    failed=0    skipped=1    rescued=0    ignored=0

INFO     Pruning extra files from scenario ephemeral directory
________________________________________________________________________________________________________________________________________ summary _________________________________________________________________________________________________________________________________________
  py37-ansible210: commands succeeded
  congratulations :)

```
    

</detail>
