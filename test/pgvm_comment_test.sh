## prepare environment
pgvm_home=`pwd`
pgvm_home=${pgvm_home}
pgvm_src=${pgvm_home}/src
pgvm_logs=${pgvm_home}/logs
pgvm_clusters=${pgvm_home}/clusters
pgvm_environments=${pgvm_home}/environments

export pgvm_home pgvm_src pgvm_logs pgvm_environments pgvm_clusters

export PATH="/bin:/usr/bin:/sbin"
export PATH=${pgvm_home}/bin:$PATH
export PATH=${pgvm_environments}/current/bin:$PATH

export LC_ALL="en_US"
export MAKE_OPTS="-j 10"

## testing presence of installed versions

pgvm list
#status=0
#match=/Please install some PostgreSQL version using 'pgvm install'!/

## testing install

pgvm install 9
#status=0
#match=/^configuring PostgreSQL Version: 9.4.4 ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

CONFIG_OPTS="--enable-cassert" pgvm install 8.4.22
#status=0
#match=/^configuring PostgreSQL Version: 8.4.22 ... done.$/

${pgvm_environments}/8.4.22/bin/pg_config
#status=0
#match=/--enable-cassert/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^    9.4.4/
#match=/^    8.4.22/


## testing uninstalled versions

pgvm use 999
#status=1

pgvm use 4
#status=1
#match=/^version 4 is not installed$/

## testing version 9.4.4

pgvm use 9.4.4
#status=0
#match=/^switched to 9.4.4$/

pgvm current
#status=0
#match=/^9.4.4$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^ => 9.4.4/
#match=/^    8.4.22/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.4.4\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/9.4.4/
#match=/PostgreSQL 9.4.4/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 9.4.4$/


## testing version 8.4.22

pgvm use 8.4.22
#status=0
#match=/^switched to 8.4.22$/

pgvm current
#status=0
#match=/^8.4.22$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^    9.4.4/
#match=/^ => 8.4.22/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(8.4.22\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/8.4.22/
#match=/--enable-cassert/
#match=/PostgreSQL 8.4.22/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 8.4.22$/


## testing clusters in 8.4.22

pgvm cluster create test
#status=0
#match=/^initializing cluster in '.+\/clusters\/8.4.22\/test'... ok!$/

pgvm cluster start test
#status=0
#match=/^starting cluster test@8.4.22$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(8.4.22\):$/
#match=/^    test  is online  at port 5433$/

pgvm cluster create latin1_cluster --encoding=latin1 --locale=en_US.iso8859-1
#status=0
#match=/^initializing cluster in '.+\/clusters\/8.4.22\/latin1_cluster'... ok!$/

## testing clusters in 9.4.4

pgvm use 9.4.4
#status=0
#match=/^switched to 9.4.4$/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.4.4\)$/

pgvm cluster create my_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.4.4\/my_cluster'... ok!$/

pgvm cluster start my_cluster
#status=0
#match=/^starting cluster my_cluster@9.4.4$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(9.4.4\):$/
#match=/^    my_cluster  is online  at port 5435$/

pgvm cluster create my_another_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.4.4\/my_another_cluster'... ok!$/

pgvm cluster start my_another_cluster
#status=0
#match=/^starting cluster my_another_cluster@9.4.4$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(9.4.4\):$/
#match=/^    my_another_cluster is online  at port 5436$/
#match=/^    my_cluster         is online  at port 5435$/

## testing stopping cluster

pgvm use 8.4.22
pgvm cluster stop test
#status=0
#match=/stopping cluster test@8.4.22/

pgvm use 9.4.4
pgvm cluster stop my_cluster
#status=0
#match=/stopping cluster my_cluster@9.4.4/

pgvm cluster stop my_another_cluster
#status=0
#match=/stopping cluster my_another_cluster@9.4.4/

pgvm cluster create to_be_removed
pgvm cluster start to_be_removed
pgvm cluster remove to_be_removed
#status=1
#match=/To remove cluster 'to_be_removed' use  'pgvm cluster remove to_be_removed --force'/

pgvm cluster remove to_be_removed --force
#status=0
#match=/stopping cluster to_be_removed@9.4.4/
#match=/removing 'to_be_removed' directory '.+\/clusters\/9.4.4\/to_be_removed' ... ok/

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
#match=/^cluster in current environment \(master\):$/
#match=/^    cl_test_master  is online  at port 5437$/

pgvm install a4c8f14
#status=0
#match=/^configuring PostgreSQL Version: a4c8f14 ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

pgvm use a4c8f14
#status=0
#match=/^switched to a4c8f14$/

pgvm cluster create cl_test_other
#status=0
#match=/^initializing cluster in '.+\/clusters\/a4c8f14\/cl_test_other'... ok!$/

pgvm cluster start cl_test_other
#status=0
#match=/^starting cluster cl_test_other@a4c8f14$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(a4c8f14\):$/
#match=/^    cl_test_other  is online  at port 5438$/

echo "select version()" | pgvm console my_cluster@9.4.4
#status=1
#match=/the cluster 'my_cluster' seems to be offline/

echo "select version()" | pgvm console test@8.4.22
#status=1
#match=/the cluster 'test' seems to be offline/

pgvm use 9.4.4
pgvm cluster start my_cluster
pgvm use 8.4.22
pgvm cluster start test
pgvm use master
echo "select version()" | pgvm console my_cluster@9.4.4
#status=0
#match=/PostgreSQL 9.4.4/

echo "select version()" | pgvm console test@8.4.22
#status=0
#match=/PostgreSQL 8.4.22/

pgvm use 9.4.4
echo "select version()" | pgvm console my_cluster
#status=0
#match=/PostgreSQL 9.4.4/

echo "select version()" | pgvm console
#status=0
#match=/PostgreSQL 9.4.4/

pgvm cluster stop my_cluster

echo "select version()" | pgvm console
#status=1
#match=/please, choose a cluster to connect/

pgvm use 8.4.22
echo "select version()" | pgvm console test
#status=0
#match=/PostgreSQL 8.4.22/
pgvm cluster stop test

pgvm install REL9_3_STABLE
#status=0
#match=/^configuring PostgreSQL Version: REL9_3_STABLE ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

pgvm use REL9_3_STABLE
#status=0
#match=/^switched to REL9_3_STABLE$/

pgvm cluster create cl_test_rel93_stable
#status=0
#match=/^initializing cluster in '.+\/clusters\/REL9_3_STABLE\/cl_test_rel93_stable'... ok!$/

pgvm cluster start cl_test_rel93_stable
#status=0
#match=/^starting cluster cl_test_rel93_stable@REL9_3_STABLE$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(REL9_3_STABLE\):$/
#match=/^    cl_test_rel93_stable  is online  at port 5439$/

pgvm cluster stop cl_test_rel93_stable
#status=0
#match=/stopping cluster cl_test_rel93_stable@REL9_3_STABLE$/
