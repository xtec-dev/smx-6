#!/bin/bash

docker volume create \
  --driver local \
  cassandra

docker run -d \
  --volume cassandra:/var/lib/cassandra/data \
  --name cassandra \
  cassandra:3.1


<<cqlsh

docker run -it --rm \
  --link cassandra:cassandra_client \
  cassandra:3.1 cqlsh cassandra

create keyspace salvador_espriu
   with replication = { 
  'class' : 'SimpleStrategy',
  'replication_factor': 1
}; 

select *
from system_schema.keyspaces
where keyspace_name = 'salvador_espriu';

cqlsh




