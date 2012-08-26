## prepare environment
export pgvm_home=`pwd`
export LC_ALL="en_US"
export PATH="$pgvm_home/bin:$pgvm_home/environments/current/bin:/bin:/usr/bin"
export MAKE_OPTS="-j 10"

## testing presence of installed versions

pgvm list
#status=0
#match=/Please, install a PostgreSQL Version!/

## testing install

pgvm install 9
#status=0
#match=/^configuring PostgreSQL Version: 9.1.5 ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

CONFIG_OPTS="--enable-cassert" pgvm install 8.4.11
#status=0
#match=/^configuring PostgreSQL Version: 8.4.11 ... done.$/

$pgvm_home/environments/8.4.11/bin/pg_config
#status=0
#match=/--enable-cassert/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^    PostgreSQL 9.1.5 .+$/
#match=/^    PostgreSQL 8.4.11 .+$/


## testing uninstalled versions

pgvm use 999
#status=1
#match=/^version 999 is not installed$/


## testing version 9.1.5

pgvm use 9.1.5
#status=0
#match=/^switched to 9.1.5$/

pgvm current
#status=0
#match=/^9.1.5$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^ => PostgreSQL 9.1.5 .+$/
#match=/^    PostgreSQL 8.4.11 .+$/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.1.5\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/9.1.5/
#match=/PostgreSQL 9.1.5/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 9.1.5$/


## testing version 8.4.11

pgvm use 8.4.11
#status=0
#match=/^switched to 8.4.11$/

pgvm current
#status=0
#match=/^8.4.11$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^    PostgreSQL 9.1.5 .+$/
#match=/^ => PostgreSQL 8.4.11 .+$/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(8.4.11\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/8.4.11/
#match=/--enable-cassert/
#match=/PostgreSQL 8.4.11/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 8.4.11$/


## testing clusters in 8,4.11

pgvm cluster create test
#status=0
#match=/^initializing cluster in '.+\/clusters\/8.4.11\/test'... ok!$/

pgvm cluster start test
#status=0
#match=/^starting cluster test@8.4.11$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(8.4.11\):$/
#match=/^    test  is online  at port 5433$/

## testing clusters in 8,4.11

pgvm use 9.1.5
#status=0
#match=/^switched to 9.1.5$/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.1.5\)$/

pgvm cluster create my_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.1.5\/my_cluster'... ok!$/

pgvm cluster start my_cluster
#status=0
#match=/^starting cluster my_cluster@9.1.5$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(9.1.5\):$/
#match=/^    my_cluster  is online  at port 5434$/

pgvm cluster create my_another_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.1.5\/my_another_cluster'... ok!$/

pgvm cluster start my_another_cluster
#status=0
#match=/^starting cluster my_another_cluster@9.1.5$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(9.1.5\):$/
#match=/^    my_another_cluster is online  at port 5435$/
#match=/^    my_cluster         is online  at port 5434$/

## testing stopping cluster

pgvm use 8.4.11
pgvm cluster stop test
#status=0
#match=/stopping cluster test@8.4.11/

pgvm use 9.1.5
pgvm cluster stop my_cluster
#status=0
#match=/stopping cluster my_cluster@9.1.5/

pgvm cluster stop my_another_cluster
#status=0
#match=/stopping cluster my_another_cluster@9.1.5/
