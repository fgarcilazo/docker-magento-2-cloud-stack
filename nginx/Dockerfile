FROM nginx:latest
RUN groupadd -g 2000 apache && useradd -d /home/apache -u 2000 -g 2000 apache
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf