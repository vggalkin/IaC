# Спринт 1
## Создание инфраструктуры

### Создание Service Account и Storage Bucket для хранения состояния

1. создаем и заполняем файл с чувствительными данными

```console
cd terreformbucket
touch terraform.tfvars
```
Заполняем

![tfvars](https://user-images.githubusercontent.com/3630798/197512071-042196d5-44be-44ac-ad88-c3290cafc1d9.png)



```console
cd terreformbucket
terraform init
terraform apply
```
