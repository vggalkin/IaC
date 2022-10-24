# Спринт 1
## Создание инфраструктуры

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

## Автоматизируем устанвоку необходимых компонентов при помощи Ansible
