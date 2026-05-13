flaskbb docker container

How to get it running

Build the container:

    * `docker build -t gordonjcp/flaskbb`

Start the Docker Compose project:

    * `docker-compose up`

Create the database and install flaskbb:

    * open a terminal and go to the flaskbb-docker directory
    * `docker-compose exec postgres su - postgres -c "createdb flaskbb"`
    * `docker-compose exec postgres su - postgres -c "createuser --pwprompt --interactive"`
    * Enter a username and password (twice) and say "no" to the three questions
      This needs to be the same as the username and password in `config/flaskbb.cfg`, by
      default flaskbb/asdfasdf
    * `docker-compose exec flaskbb make install`
    * Follow the prompts to create a flask admin user

FlaskBB will be available on http://localhost:5000

This should be proxied through something like nginx