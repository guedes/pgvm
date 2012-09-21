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
#match=/^configuring PostgreSQL Version: 9.2.0 ... done.$/
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
#match=/^    9.2.0/
#match=/^    8.4.11/


## testing uninstalled versions

pgvm use 999
#status=1
#match=/^version 999 is not installed$/


## testing version 9.2.0

pgvm use 9.2.0
#status=0
#match=/^switched to 9.2.0$/

pgvm current
#status=0
#match=/^9.2.0$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^ => 9.2.0/
#match=/^    8.4.11/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.2.0\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/9.2.0/
#match=/PostgreSQL 9.2.0/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 9.2.0$/


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
#match=/^    9.2.0/
#match=/^ => 8.4.11/

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

pgvm cluster create latin1_cluster --encoding=latin1 --locale=en_US
#status=0
#match=/^initializing cluster in '.+\/clusters\/8.4.11\/latin1_cluster'... ok!$/

## testing clusters in 9.2.0

pgvm use 9.2.0
#status=0
#match=/^switched to 9.2.0$/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.2.0\)$/

pgvm cluster create my_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.2.0\/my_cluster'... ok!$/

pgvm cluster start my_cluster
#status=0
#match=/^starting cluster my_cluster@9.2.0$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(9.2.0\):$/
#match=/^    my_cluster  is online  at port 5435$/

pgvm cluster create my_another_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.2.0\/my_another_cluster'... ok!$/

pgvm cluster start my_another_cluster
#status=0
#match=/^starting cluster my_another_cluster@9.2.0$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(9.2.0\):$/
#match=/^    my_another_cluster is online  at port 5436$/
#match=/^    my_cluster         is online  at port 5435$/

## testing stopping cluster

pgvm use 8.4.11
pgvm cluster stop test
#status=0
#match=/stopping cluster test@8.4.11/

pgvm use 9.2.0
pgvm cluster stop my_cluster
#status=0
#match=/stopping cluster my_cluster@9.2.0/

pgvm cluster stop my_another_cluster
#status=0
#match=/stopping cluster my_another_cluster@9.2.0/

pgvm cluster create to_be_removed
pgvm cluster start to_be_removed
pgvm cluster remove to_be_removed
#status=1
#match=/To remove cluster 'to_be_removed' use  'pgvm cluster remove to_be_removed --force'/

pgvm cluster remove to_be_removed --force
#status=0
#match=/stopping cluster to_be_removed@9.2.0/
#match=/removing 'to_be_removed' directory '.+\/clusters\/9.2.0\/to_be_removed' ... ok/

pgvm install master
#status=0
#match=/^configuring PostgreSQL Version: master ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

pgvm use master
#status=0
#match=/^switched to master$/

pgvm cluster create cl_test_master
#status=0
#match=/^initializing cluster in '.+\/clusters\/master\/cl_test_master'... ok!$/

pgvm cluster start cl_test_master
#status=0
#match=/^starting cluster cl_test_master@master$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(master\):$/
#match=/^    cl_test_master  is online  at port 5437$/

pgvm install 088c065
#status=0
#match=/^configuring PostgreSQL Version: 088c065 ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

pgvm use 088c065
#status=0
#match=/^switched to 088c065$/

pgvm cluster create cl_test_other
#status=0
#match=/^initializing cluster in '.+\/clusters\/088c065\/cl_test_other'... ok!$/

pgvm cluster start cl_test_other
#status=0
#match=/^starting cluster cl_test_other@088c065$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(088c065\):$/
#match=/^    cl_test_other  is online  at port 5438$/

pgvm install REL9_2_STABLE
#status=0
#match=/^configuring PostgreSQL Version: REL9_2_STABLE ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

pgvm use REL9_2_STABLE
#status=0
#match=/^switched to REL9_2_STABLE$/

pgvm cluster create cl_test_rel92_stable
#status=0
#match=/^initializing cluster in '.+\/clusters\/REL9_2_STABLE\/cl_test_rel92_stable'... ok!$/

pgvm cluster start cl_test_rel92_stable
#status=0
#match=/^starting cluster cl_test_rel92_stable@REL9_2_STABLE$/

pgvm cluster list
#status=0
#match=/^cluster in current enviroment \(REL9_2_STABLE\):$/
#match=/^    cl_test_rel92_stable  is online  at port 5439$/

pgvm cluster stop cl_test_rel92_stable
#status=0
#match=/stopping cluster cl_test_rel92_stable@REL9_2_STABLE$/
