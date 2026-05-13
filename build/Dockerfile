# build flaskbb from github
FROM alpine 
#as builder


# make pip3 uv


# basics for building the required Python packages
RUN apk update && apk -U add make py3-pip py3-psycopg2 uwsgi uwsgi-http uwsgi-python3

WORKDIR /app
COPY ./flaskbb/ /app/flaskbb

RUN rm /usr/lib/python*/EXTERNALLY-MANAGED

# build the flaskbb package
WORKDIR /app/flaskbb
RUN pip3 install -r requirements.txt

RUN mkdir /app/flaskbb/instance
RUN chown -R uwsgi:uwsgi /app/flaskbb/instance
RUN mkdir /app/flaskbb/whoosh_index
RUN chown -R uwsgi:uwsgi /app/flaskbb/whoosh_index

CMD ["flaskbb",  "run",  "--host 0.0.0.0"]


