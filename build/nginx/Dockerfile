# build flaskbb from github
FROM nginx:alpine as flaskbb-nginx

WORKDIR /srv

# default FlaskBB static files (javascript, favicon)
COPY ./flaskbb/flaskbb/flaskbb/static /srv/static

# default FlaskBB Aurora themes
COPY ./flaskbb/flaskbb/flaskbb/themes /srv/aurora

# default config file
CMD mkdir /etc/nginx-flaskbb/
COPY ./nginx/nginx.conf /etc/nginx-flaskbb/

CMD nginx -c /etc/nginx-flaskbb/nginx.conf
