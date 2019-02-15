FROM mdillon/postgis:11

RUN apt-get update \
    && apt-get install -y --no-install-recommends build-essential \
                                                  git \
                                                  ca-certificates \
                                                  postgresql-server-dev-11

RUN git clone https://github.com/mlt/temporal_tables.git \
 && cd ./temporal_tables \
 && git checkout pg11

RUN cd ./temporal_tables && make && make install

RUN apt purge -y build-essential \
                 git \
                 ca-certificates \
                 postgresql-server-dev-11 \
                 && rm -rf /var/lib/apt/lists/*

COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh  
