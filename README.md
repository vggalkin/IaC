# Спринт 1
## Создание инфраструктуры и автоматизация установки компонентов

### Создание Service Account и Storage Bucket для хранения состояния

1. Создаем и заполняем файл с чувствительными данными
```console
cd terraformbucket
touch terraform.tfvars
```
Заполняем

![tfvars](https://user-images.githubusercontent.com/3630798/197512071-042196d5-44be-44ac-ad88-c3290cafc1d9.png)

2. Инициализируем и применяем
```console
terraform init
terraform apply
```
3. Считываем ключи из output
```console
terraform output access_key # Записываем
terraform output secret_key # Записываем
```
### Создание инфраструктуры

1. Создаем ключи
```console
cd ../
ssh-keygen -t rsa
cp ~/.ssh/id_rsa* ./
```

2. Переходим в основной Terraform проект, инициализируем с использованием access_key и secret_key, полученные из output TerraformBucket проекта и применяем
```console
cd terraform
terraform init -backend-config="access_key=<access_key>" -backend-config="secret_key=<secret_key>"
terraform apply
```
Итог: 3 виртуальные машины

![yandex_vms](https://user-images.githubusercontent.com/3630798/197519640-bdd15257-7afc-46d3-a93a-f0799ca51aa0.png)


### Автоматизируем установку необходимых компонентов при помощи Ansible

Переходим в каталог ansible и запускаем playbook
```console
cd ../ansible
ansible-playbook -i ../inventory.ini -u ubuntu ansible_playbook.yml
```
Итог: сконфигурированные ВМ с необходимыми компонентами
![ansible_playbook_result](https://user-images.githubusercontent.com/3630798/197524800-74d4580c-c399-4097-99ee-3ff85429787c.png)
