FROM nginx:1.22.1

# Создаём директории для статики и медиа
RUN mkdir -p /var/html/static /var/html/media

# Копируем собранный фронтенд
COPY frontend/build/ /usr/share/nginx/html/

# Копируем конфиг Nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf