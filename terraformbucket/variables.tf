variable "zone" {                                # Используем переменную для передачи в конфиг инфраструктуры
  description = "Use specific availability zone" # Опционально описание переменной
  type        = string                           # Опционально тип переменной
  default     = "ru-central1-a"                  # Опционально значение по умолчанию для переменной
}

variable "cloud_id" {
  description = "Yandex Cloud Id"
}

variable "folder_id" {
  description = "Yandex Folder ID"
}

variable "token" {
  description = "Yandex Token"
}

variable "service_account" {
  description = "Your Service Account Name"
}
