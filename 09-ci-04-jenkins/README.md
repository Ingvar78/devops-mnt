# Домашнее задание к занятию "09.04 Jenkins"

<details>
<summary>Подготовка к выполнению</summary>

## Подготовка к выполнению

1. Создать 2 VM: для jenkins-master и jenkins-agent.

В качестве VM используется две виртуальные машины: [Centos 7/4VCPU/4GB RAM](./Centos7/ReadMe.md), так же VM можно создать через [terraform](./terraform/)

2. Установить jenkins при помощи [playbook](./infrastructure)'a.

```bash
ansible-playbook -i inventory/cicd/stage.yml site.yml
```

3. Запустить и проверить работоспособность.

http://{jenkins_ip}:8080

4. Сделать первоначальную настройку.

</details>

## Основная часть

1. Сделать Freestyle Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.

<details>
<summary>Freestyle Job</summary>

![FreeStyle Job 1](./src/Screenshot1.png)

![FreeStyle Job 2](./src/Screenshot2.png)

</details>


2. Сделать Declarative Pipeline Job, который будет запускать `molecule test` из любого вашего репозитория с ролью.
3. Перенести Declarative Pipeline в репозиторий в файл `Jenkinsfile`.


<details>
<summary>Multibranch Pipeline Job</summary>

![Declarative Pipeline Job 1](./src/Screenshot3.png)

![Declarative Pipeline Job 2](./src/Screenshot4.png)


[Jenkins File](https://github.com/Ingvar78/vector-role/blob/main/Jenkinsfile)

</details>

4. Создать Multibranch Pipeline на запуск `Jenkinsfile` из репозитория.


<details>
<summary>Multibranch Pipeline Job</summary>

![Multibranch Pipeline Job 1](./src/Screenshot5.png)

![Multibranch Pipeline Job 2](./src/Screenshot6.png)

![Multibranch Pipeline 3](./src/Screenshot7.png)

![Multibranch Pipeline 4](./src/Screenshot8.png)

[Jenkins File](https://github.com/Ingvar78/vector-role/blob/main/Jenkinsfile)

</details>


5. Создать Scripted Pipeline, наполнить его скриптом из [pipeline](./pipeline).
6. Внести необходимые изменения, чтобы Pipeline запускал `ansible-playbook` без флагов `--check --diff`, если не установлен параметр при запуске джобы (prod_run = True), по умолчанию параметр имеет значение False и запускает прогон с флагами `--check --diff`.
7. Проверить работоспособность, исправить ошибки, исправленный Pipeline вложить в репозиторий в файл `ScriptedJenkinsfile`.
8. Отправить ссылку на репозиторий с ролью и Declarative Pipeline и Scripted Pipeline.

<details>
<summary>Multibranch Pipeline Job</summary>

![Scripted Pipeline](./src/Screenshot9.png)

</details>


[Scripted Pipeline](https://github.com/Ingvar78/example-playbook/blob/master/JenkinsScripted)

## Необязательная часть

1. Создать скрипт на groovy, который будет собирать все Job, которые завершились хотя бы раз неуспешно. Добавить скрипт в репозиторий с решением с названием `AllJobFailure.groovy`.
2. Создать Scripted Pipeline таким образом, чтобы он мог сначала запустить через Ya.Cloud CLI необходимое количество инстансов, прописать их в инвентори плейбука и после этого запускать плейбук. Тем самым, мы должны по нажатию кнопки получить готовую к использованию систему.

---

### Как оформить ДЗ?

Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.

---
