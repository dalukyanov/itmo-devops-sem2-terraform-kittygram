# Используем официальный образ Nginx
FROM nginx:1.22.1

COPY ./frontend/build /usr/share/nginx/html
COPY ./nginx.conf /etc/nginx/conf.d/default.conf