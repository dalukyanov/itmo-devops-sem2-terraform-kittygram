FROM nginx:1.22.1
RUN mkdir -p /var/html/static /var/html/media
# Из conf.d подсасываются все конфиги
COPY nginx.conf /etc/nginx/conf.d/default.conf