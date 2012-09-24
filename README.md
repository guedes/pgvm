[![Build Status](https://secure.travis-ci.org/guedes/pgvm.png?branch=master)](http://travis-ci.org/guedes/pgvm)

PostgreSQL Version Manager - pgvm
==================================

PostgreSQL Version Manager, or simply `pgvm` is a tool to manage multiple PostgreSQL installations.

Installation
------------

To install just type:

    curl -s -L https://raw.github.com/guedes/pgvm/master/bin/pgvm-self-install | bash

Then open a new terminal or type:

    source ~/.bashrc

and voilà!

An example session
------------------

Once you installed `pgvm` you could like to see which
PostgreSQL versions were installed. In fact the `pgvm`
installation didn't install any.

You list all PostgreSQL installed version with the
action `list`:

    $ pgvm list
    Please, install a PostgreSQL Version!

As you can see, there isn't any. Lets install one
using the action `install`:

    $ pgvm install 9
    downloading 'http://ftp.postgresql.org/pub/source/v9.2.0/postgresql-9.2.0.tar.gz', please be patient... done.
    checking 'postgresql-9.2.0.tar.gz' integrity... done.
    extracting postgresql-9.2.0.tar.gz ... done.
    configuring PostgreSQL Version: 9.2.0 ... done.
    compiling ... done.
    installing ... done.

Notice that the version supplied was `9` but `pgvm`
found that the last PostgreSQL version is `9.2.0`.

Now suppose we want to install the `8.4.11` version
with `cassert` enabled, using more cores of our
processors, just export `MAKE_OPTS` and `CONFIG_OPTS`
with the options for `make` and `configure` respectively,
like bellow:

    $ MAKE_OPTS="-j 10" CONFIG_OPTS="--enable-cassert" pgvm install 8.4.11
    downloading 'http://ftp.postgresql.org/pub/source/v8.4.11/postgresql-8.4.11.tar.gz', please be patient... done.
    checking 'postgresql-8.4.11.tar.gz' integrity... done.
    extracting postgresql-8.4.11.tar.gz ... done.
    configuring PostgreSQL Version: 8.4.11 ... done.
    compiling ... done.
    installing ... done.

So now you have two PostgreSQL versions installed:

    $ pgvm list
    PostgreSQL Installed Version:

        8.4.11
        9.2.0

Then `pgvm` allow you `use` one of them:

    $ pgvm use 92.0
    version 92.0 is not installed

Ops! A little typo, sorry! :/

    $ pgvm use 9.2.0
    switched to 9.2.0

Ah! So now my `current` version is `9.2.0`? Well
lets just confirm:

    $ pgvm current
    9.2.0

    $ pgvm list
    PostgreSQL Installed Version:

        8.4.11
     => 9.2.0

Seems that `pgvm` tell us in two ways, by the
action `current` or when listing version by
placing a `=>` before the version we are using!

The binaries are there in the correct version:

    $ pg_config --version
    PostgreSQL 9.2.0

    $ psql --version
    psql (PostgreSQL) 9.2.0

    $ pgvm use 8.4.11

    $ pg_config --version
    PostgreSQL 8.4.11

    $ psql --version
    psql (PostgreSQL) 8.4.11

Ok, this is nice but how about clusters? Lets
create one!

    $ pgvm use 9.2.0
    switched to 9.2.0

    $ pgvm cluster list
    there is no clusters in current environment (9.2.0)

    $ pgvm cluster create my_cluster
    initializing cluster in '/home/guedes/pgvm/clusters/9.2.0/my_cluster'... ok!

    $ pgvm cluster start my_cluster
    starting cluster my_cluster@9.2.0
    LOG:  database system was shut down at 2012-09-22 21:55:03 UTC
    LOG:  database system is ready to accept connections
    LOG:  autovacuum launcher started

    $ pgvm cluster list
    cluster in current enviroment (9.2.0):

        my_cluster  is online  at port 5433

    $ pgvm cluster create my_another_cluster
    initializing cluster in '/home/guedes/pgvm/clusters/9.2.0/my_another_cluster'... ok!

    $ pgvm cluster start my_another_cluster
    starting cluster my_another_cluster@9.2.0
    LOG:  database system was shut down at 2012-09-22 21:55:06 UTC
    LOG:  database system is ready to accept connections
    LOG:  autovacuum launcher started

    $ pgvm cluster list
    cluster in current enviroment (9.2.0):

        my_another_cluster is online  at port 5434
        my_cluster         is online  at port 5433

Now we have two online clusters and notice that
`pgvm` choose specific ports to each one.

You can pass options to `initdb` when creating
a new cluster:

    $ pgvm use 8.4.11
    switched to 8.4.11

    $ pgvm cluster create latin1_cluster --encoding=latin1 --locale=en_US

And you can remove some cluster

    $ pgvm cluster create to_be_removed
    initializing cluster in '/home/guedes/pgvm/clusters/8.4.11/to_be_removed'... ok!

    $ pgvm cluster start to_be_removed
    starting cluster to_be_removed@8.4.11
    LOG:  database system was shut down at 2012-09-22 21:55:13 UTC
    LOG:  database system is ready to accept connections
    LOG:  autovacuum launcher started

    $ pgvm cluster remove to_be_removed
    To remove cluster 'to_be_removed' use  'pgvm cluster remove to_be_removed --force'

    $ pgvm cluster remove to_be_removed --force
    stopping cluster to_be_removed@8.4.11
    LOG:  received smart shutdown request
    LOG:  autovacuum launcher shutting down
    LOG:  shutting down
    LOG:  database system is shut down
    removing 'to_be_removed' directory '/home/guedes/pgvm/clusters/8.4.11/to_be_removed' ... ok

Maybe you are a PostgreSQL developer and wants to install from
`master` branch ...

    $ pgvm install master
    getting postgres from 'git://git.postgresql.org/git/postgresql.git'
    Cloning into '/home/guedes/pgvm/src/postgresql-clone'...
    configuring PostgreSQL Version: master ... done.
    compiling ... done.
    installing ... done.

    $ pgvm use master
    switched to master

    $ pgvm cluster create cl_test_master
    initializing cluster in '/home/guedes/pgvm/clusters/master/cl_test_master'... ok!

    $ pgvm cluster start cl_test_master
    starting cluster cl_test_master@master
    LOG:  database system was shut down at 2012-09-22 21:58:49 UTC
    LOG:  database system is ready to accept connections
    LOG:  autovacuum launcher started

    $ pgvm cluster list
    cluster in current enviroment (master):

        cl_test_master  is online  at port 5436

... or from a specific commit to test something ...

    $ pgvm install 088c065
    configuring PostgreSQL Version: 088c065 ... done.
    compiling ... done.
    installing ... done.

    $ pgvm use 088c065
    switched to 088c065

    $ pgvm cluster create cl_test_other
    initializing cluster in '/home/guedes/pgvm/clusters/088c065/cl_test_other'... ok!

    $ pgvm cluster start cl_test_other
    starting cluster cl_test_other@088c065
    LOG:  database system was shut down at 2012-09-22 22:01:06 UTC
    LOG:  database system is ready to accept connections
    LOG:  autovacuum launcher started

    $ pgvm cluster list
    cluster in current enviroment (088c065):

        cl_test_other  is online  at port 5437

By the way, you can start a console on any cluster:

    $ pgvm current
    088c065

    $ pgvm console my_cluster@9.2.0
    connecting to cluster 'test' on port '5433' ...

    psql (9.2.0)
    Type "help" for help.

    postgres=#

Or you can redirect commands to:

    $ echo "select version()" | pgvm console latin1_cluster@8.4.11
    connecting to cluster 'test' on port '5435' ...

                                               version
    ----------------------------------------------------------------------------------------------
     PostgreSQL 8.4.11 on x86_64-unknown-linux-gnu, compiled by gcc (Debian 4.7.2-1) 4.7.2, 64-bit
    (1 row)


Dependencies
------------

  `pvgm` has the following dependencies:

  * `bash`
  * `curl` or `wget`
  * `c compiler`
  * `gmake`
  * `readline`
  * `zlib`
  * `git` in order to get PostgreSQL trunk version.


TODO
----

See the [issue list of enhancements](https://github.com/guedes/pgvm/issues?labels=enhancement&page=1&state=open).


Origins
-------

`pgvm` was inspired by [rvm](https://rvm.beginrescueend.com), a Ruby enVironment Manager created by [Wayne E. Seguin](http://wayneseguin.us).


Copyright and License
---------------------

Copyright (c) 2012 Dickson S. Guedes.

This module is free software; you can redistribute it and/or modify it under
the [PostgreSQL License](http://www.opensource.org/licenses/postgresql).

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose, without fee, and without a written agreement is
hereby granted, provided that the above copyright notice and this paragraph
and the following two paragraphs appear in all copies.

In no event shall Dickson S. Guedes be liable to any party for direct,
indirect, special, incidental, or consequential damages, including lost
profits, arising out of the use of this software and its documentation, even
if Dickson S. Guedes has been advised of the possibility of such damage.

Dickson S. Guedes specifically disclaims any warranties, including, but not
limited to, the implied warranties of merchantability and fitness for a
particular purpose. The software provided hereunder is on an "as is" basis,
and Dickson S. Guedes has no obligations to provide maintenance, support,
updates, enhancements, or modifications.
