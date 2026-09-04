# Kittygram + Terraform

В данном проекте разворачивается инфраструктура в Яндекс.Облаке через Terraform. После чего деплоится Kittygram на созданную VM средствами GitHub Actions.

## Основные компоненты

- `tests.yml` — Вводные данные для проверки проекта
- `.github/workflows/terraform.yml` - Terraform запускается с опциями: `plan`, `apply`, `destroy`.
- `.github/workflows/deploy.yml` — деплой. Сборка, загрузка на созданный хост, запуск, тесты, уведомление в Telegram
- `infra/` — Описание конфигурации Terraform
- `docker-compose.production.yml` — Docker compose для целевого окружения

## Создание сервисного аккаунта (необходимо из-за изменения политики Yandex Cloud по работе с YC_TOKEN)

```text
yc resource-manager folder add-access-binding <YC_FOLDER_ID> \
  --role editor \
  --service-account-name terraform-sa

dalukyanov@Mac cloud-services-engineer-vms % yc resource-manager folder add-access-binding <YC_FOLDER_ID> \
  --role editor \
  --service-account-name terraform-sa
done (2s)
effective_deltas:
  - action: ADD
    access_binding:
      role_id: editor
      subject:
        id: ******
        type: serviceAccount


dalukyanov@Mac cloud-services-engineer-vms % yc iam key create \
  --service-account-name terraform-sa \
  --output key.json
id: ********
service_account_id: ******
created_at: "2026-09-04T10:23:33.232586971Z"
key_algorithm: RSA_2048
```

## Полный список необходимых GitHub секретов

```text
APP_BUCKET_NAME
DJANGO_SECRET_KEY
DOCKERHUB_PASSWORD
DOCKERHUB_USERNAME
POSTGRES_DB
POSTGRES_PASSWORD
POSTGRES_USER
SSH_PRIVATE_KEY
SSH_PUBLIC_KEY
TELEGRAM_TO
TELEGRAM_TOKEN
VM_USER
YC_CLOUD_ID
YC_FOLDER_ID
YC_SERVICE_ACCOUNT_KEY
YC_STORAGE_ACCESS_KEY
YC_STORAGE_SECRET_KEY
YC_TFSTATE_BUCKET
YC_TOKEN # Подключение будет через сервисный аккаунт из-за изменений в политике Yandex Cloud в июле 2026
YC_ZONE
```

## Создание сервисного аккаунта

## Порядок запуска

1. Создайте бакет для Terraform state, его имя хранится в YC_TFSTATE_BUCKET
2. Создать GitHub Secrets из списка выше.
3. Запустите workflow `Terraform` с action `plan`.
4. Запустите workflow `Terraform` с action `apply`.
5. Возьмите `kittygram_url` из output Terraform.
6. Заполните `tests.yml` реальным URL вида `http://<external_ip>:9000`.
7. Сделайте push в `main`, чтобы запустить `.github/workflows/deploy.yml`.

## Проверка приложения

```bash
curl http://<external_ip>:9000
curl http://<external_ip>:9000/api/cats/
```
