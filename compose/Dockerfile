FROM python:3.11.1-alpine3.17

# Description: A quick and dirty Bottle Python file server monkey patched to provide asynchronous connections

# Author Andrew Tomczak, ajwsurfer@gmail.com, AJ Surf Co
# Date: January 22, 2024

############# requirements installation ########################################
WORKDIR /srv
RUN pip install fastapi
RUN pip install uvicorn
RUN pip install jinja2
#RUN pip install pydantic
#RUN pip install couchdb  # Install CouchDB library

############# setup server #####################################################
RUN mkdir -p /srv/data
COPY main.py /srv/
COPY favicon.ico /srv/
#COPY download_counter.json /srv/
RUN set -x ; \
  addgroup -g 82 -S www-data ; \
  adduser -u 82 -D -S -G www-data www-data && exit 0 ; exit 1

RUN chown -Rf www-data:www-data /srv/*
#RUN chmod +rw /srv/download_counter.json
USER www-data

############# debug ############################################################
ENV TERM xterm

############# runtime ##########################################################
EXPOSE 8000
CMD [ "uvicorn", "main:app", "--reload", "--host", "0.0.0.0" ]

