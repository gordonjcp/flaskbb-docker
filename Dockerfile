# build flaskbb from github

FROM alpine as builder

# basics for building the required Python packages
RUN apk update && apk -U add gcc git py3-pip py3-wheel jpeg-dev musl-dev python3-dev zlib-dev
WORKDIR /app
# rebuild if there's a new git version
ADD https://api.github.com/repos/gordonjcp/flaskbb/git/refs/heads/master version.json
RUN git clone https://github.com/gordonjcp/flaskbb.git

WORKDIR /app/wheel
# build custom flask-allows and Pillow
RUN python3 -m pip wheel --no-deps -w /app/wheel flask-allows@git+https://github.com/gordonjcp/flask-allows.git@f/Cut-down-on-warnings#egg=flask-allows
RUN python3 -m pip wheel --no-deps -w /app/wheel Pillow

# build the flaskbb package
WORKDIR /app/flaskbb
RUN python3 -m pip wheel -w /app/wheel --no-deps .

# build actual flaskbb container
FROM alpine as flaskbb
RUN apk update && apk -U add python3 py3-pip libjpeg py3-psycopg2 py3-gunicorn

# copy in the packages we built in the previous step
WORKDIR /app/wheel
COPY --from=builder /app/wheel/*whl /app/wheel/

# install
RUN python3 -m pip install ./Pillow* ./flask_allows* ./FlaskBB*

# clean up packages
RUN rm -rf /app/wheel

WORKDIR /app/flaskbb
COPY wsgi.py .
CMD gunicorn -w 1 -b 0.0.0.0:5000 wsgi:flaskbb --pid gunicorn.pid-

