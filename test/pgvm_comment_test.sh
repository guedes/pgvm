## prepare environment
pgvm_home=`pwd`
pgvm_home=${pgvm_home}
pgvm_logs=${pgvm_home}/logs
pgvm_clusters=${pgvm_home}/clusters
pgvm_environments=${pgvm_home}/environments

export pgvm_home pgvm_logs pgvm_environments pgvm_clusters

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
#match=/^configuring PostgreSQL Version: 9.3.2 ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

CONFIG_OPTS="--enable-cassert" pgvm install 8.4.19
#status=0
#match=/^configuring PostgreSQL Version: 8.4.19 ... done.$/

${pgvm_environments}/8.4.19/bin/pg_config
#status=0
#match=/--enable-cassert/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^    9.3.2/
#match=/^    8.4.19/


## testing uninstalled versions

pgvm use 999
#status=1
#match=/^version 999 is not installed$/


## testing version 9.3.2

pgvm use 9.3.2
#status=0
#match=/^switched to 9.3.2$/

pgvm current
#status=0
#match=/^9.3.2$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^ => 9.3.2/
#match=/^    8.4.19/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.3.2\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/9.3.2/
#match=/PostgreSQL 9.3.2/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 9.3.2$/


## testing version 8.4.19

pgvm use 8.4.19
#status=0
#match=/^switched to 8.4.19$/

pgvm current
#status=0
#match=/^8.4.19$/

pgvm list
#status=0
#match=/^PostgreSQL Installed Version:$/
#match=/^    9.3.2/
#match=/^ => 8.4.19/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(8.4.19\)$/

pg_config --configure --version
#status=0
#match=/--prefix=.+\/environments/8.4.19/
#match=/--enable-cassert/
#match=/PostgreSQL 8.4.19/

psql --version
#status=0
#match=/^psql \(PostgreSQL\) 8.4.19$/


## testing clusters in 8.4.19

pgvm cluster create test
#status=0
#match=/^initializing cluster in '.+\/clusters\/8.4.19\/test'... ok!$/

pgvm cluster start test
#status=0
#match=/^starting cluster test@8.4.19$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(8.4.19\):$/
#match=/^    test  is online  at port 5433$/

pgvm cluster create latin1_cluster --encoding=latin1 --locale=en_US.iso8859-1
#status=0
#match=/^initializing cluster in '.+\/clusters\/8.4.19\/latin1_cluster'... ok!$/

## testing clusters in 9.3.2

pgvm use 9.3.2
#status=0
#match=/^switched to 9.3.2$/

pgvm cluster list
#status=1
#match=/^there is no clusters in current environment \(9.3.2\)$/

pgvm cluster create my_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.3.2\/my_cluster'... ok!$/

pgvm cluster start my_cluster
#status=0
#match=/^starting cluster my_cluster@9.3.2$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(9.3.2\):$/
#match=/^    my_cluster  is online  at port 5435$/

pgvm cluster create my_another_cluster
#status=0
#match=/^initializing cluster in '.+\/clusters\/9.3.2\/my_another_cluster'... ok!$/

pgvm cluster start my_another_cluster
#status=0
#match=/^starting cluster my_another_cluster@9.3.2$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(9.3.2\):$/
#match=/^    my_another_cluster is online  at port 5436$/
#match=/^    my_cluster         is online  at port 5435$/

## testing stopping cluster

pgvm use 8.4.19
pgvm cluster stop test
#status=0
#match=/stopping cluster test@8.4.19/

pgvm use 9.3.2
pgvm cluster stop my_cluster
#status=0
#match=/stopping cluster my_cluster@9.3.2/

pgvm cluster stop my_another_cluster
#status=0
#match=/stopping cluster my_another_cluster@9.3.2/

pgvm cluster create to_be_removed
pgvm cluster start to_be_removed
pgvm cluster remove to_be_removed
#status=1
#match=/To remove cluster 'to_be_removed' use  'pgvm cluster remove to_be_removed --force'/

pgvm cluster remove to_be_removed --force
#status=0
#match=/stopping cluster to_be_removed@9.3.2/
#match=/removing 'to_be_removed' directory '.+\/clusters\/9.3.2\/to_be_removed' ... ok/

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

pgvm install 86ef479
#status=0
#match=/^configuring PostgreSQL Version: 86ef479 ... done.$/
#match=/^compiling ... done.$/
#match=/^installing ... done.$/

pgvm use 86ef479
#status=0
#match=/^switched to 86ef479$/

pgvm cluster create cl_test_other
#status=0
#match=/^initializing cluster in '.+\/clusters\/86ef479\/cl_test_other'... ok!$/

pgvm cluster start cl_test_other
#status=0
#match=/^starting cluster cl_test_other@86ef479$/

pgvm cluster list
#status=0
#match=/^cluster in current environment \(86ef479\):$/
#match=/^    cl_test_other  is online  at port 5438$/

echo "select version()" | pgvm console my_cluster@9.3.2
#status=1
#match=/the cluster 'my_cluster' seems to be offline/

echo "select version()" | pgvm console test@8.4.19
#status=1
#match=/the cluster 'test' seems to be offline/

pgvm use 9.3.2
pgvm cluster start my_cluster
pgvm use 8.4.19
pgvm cluster start test
pgvm use master
echo "select version()" | pgvm console my_cluster@9.3.2
#status=0
#match=/PostgreSQL 9.3.2/

echo "select version()" | pgvm console test@8.4.19
#status=0
#match=/PostgreSQL 8.4.19/

pgvm use 9.3.2
echo "select version()" | pgvm console my_cluster
#status=0
#match=/PostgreSQL 9.3.2/

echo "select version()" | pgvm console
#status=0
#match=/PostgreSQL 9.3.2/

pgvm cluster stop my_cluster

echo "select version()" | pgvm console
#status=1
#match=/please, choose a cluster to connect/

pgvm use 8.4.19
echo "select version()" | pgvm console test
#status=0
#match=/PostgreSQL 8.4.19/
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
