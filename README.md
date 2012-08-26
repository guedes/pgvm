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


Usage
-----

    $ pgvm help
    Usage: pgvm action [arguments]

    - actions:

      install      Installs a specific PostgreSQL version
      uninstall    Uninstalls a specific PostgreSQL version

      list         List all installed PostgreSQL versions
      use          Choose an enviroment to use

      cluster      Manipulate clusters (PGDATA directories)

      help         This help


An example session
------------------

    ~$ pgvm help

    Usage: pgvm action [arguments]

      - actions:

        install      Installs a specific PostgreSQL version
        uninstall    Uninstalls a specific PostgreSQL version

        list         List all installed PostgreSQL versions
        use          Choose an enviroment to use

        cluster      Manipulate clusters (PGDATA directories)

        help         This help


    ~$ pgvm help install

    Usage: pgvm install <version>

      <version> is the postgres semantic version that
                you want to install, a branch or a
                commit hash from postgresql git repo.

      Examples:
               pgvm install 9.0.7
               pgvm install 9.1.3
               pgvm install master
               pgvm install c89bdf7690

      You can pass MAKE_OPTS and CONFIG_OPTS for
      'make' and 'configure' respectively

      Examples:
               CONFIG_OPTS=--enable-cassert MAKE_OPTS=-j 16 pgvm install 9.1.4



    ~$ pgvm help uninstall

    Usage: pgvm uninstall <version> [OPTIONS]

      <version> is the postgres semantic version that
                you want to uninstall.

      Examples:
               pgvm uninstall 9.0.7
               pgvm uninstall 9.1.3
               pgvm uninstall 9.1.1 --purge
               pgvm uninstall --all
               pgvm uninstall --all --purge
               pgvm uninstall master


    == Options


      --all		Remove all postgres versions installed.

      --purge	Remove postgres version source.

      --force	If is the current version then remove it.


    ~$ pgvm help list

    Usage: pgvm action [arguments]

      - actions:

        install      Installs a specific PostgreSQL version
        uninstall    Uninstalls a specific PostgreSQL version

        list         List all installed PostgreSQL versions
        use          Choose an enviroment to use

        cluster      Manipulate clusters (PGDATA directories)

        help         This help


    ~$ pgvm help use

    Select a specific version of PostgreSQL to use.

    Usage: pgvm use X.Y.Z

    where X.Y.Z is the semantic version of a installed PostgreSQL

    E.g.
       ~$ pgvm use 9.1.4

    TIP: you can use 'pgvm list' to see the PostgreSQL
         installations available.


    ~$ pgvm help cluster

    Manipulates clusters within pgvm.

    Usage: pgvm cluster <action> <args>

      - action

        create      Creates a new cluster (PGDATA)
        remove      Removes a cluster
        rename      Renames a cluster
        list        List all clusters

        import      Import a cluster from tarball
        export      Export a cluster to tarball


    ~$ pgvm list
    Please, install a PostgreSQL Version!


    ~$ pgvm install 9
    downloading 'http://ftp.postgresql.org/pub/source/v9.1.4/postgresql-9.1.4.tar.gz', please be patient... done.
    checking 'postgresql-9.1.4.tar.gz' integrity... done.
    extracting postgresql-9.1.4.tar.gz ... done.
    configuring PostgreSQL Version: 9.1.4 ... done.
    compiling ... done.
    installing ... done.

    ~$ pgvm install 8.3
    downloading 'http://ftp.postgresql.org/pub/source/v8.3.19/postgresql-8.3.19.tar.gz', please be patient... done.
    checking 'postgresql-8.3.19.tar.gz' integrity... done.
    extracting postgresql-8.3.19.tar.gz ... done.
    configuring PostgreSQL Version: 8.3.19 ... done.
    compiling ... done.
    installing ... done.

    ~$ MAKE_OPTS="-j 10" CONFIG_OPTS="--enable-cassert" pgvm install 8.4.11
    downloading 'http://ftp.postgresql.org/pub/source/v8.4.11/postgresql-8.4.11.tar.gz', please be patient... done.
    checking 'postgresql-8.4.11.tar.gz' integrity... done.
    extracting postgresql-8.4.11.tar.gz ... done.
    configuring PostgreSQL Version: 8.4.11 ... done.
    compiling ... done.
    installing ... done.

    ~$ pgvm install 9.2beta2
    downloading 'http://ftp.postgresql.org/pub/source/v9.2beta2/postgresql-9.2beta2.tar.gz', please be patient... done.
    checking 'postgresql-9.2beta2.tar.gz' integrity... done.
    extracting postgresql-9.2beta2.tar.gz ... done.
    configuring PostgreSQL Version: 9.2beta2 ... done.
    compiling ... done.
    installing ... done.

    ~$ pgvm use 9.1.4
    switched to 9.1.4

    ~$ pgvm list
    PostgreSQL Installed Version:

        PostgreSQL 8.3.19  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
        PostgreSQL 8.4.11  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
     => PostgreSQL 9.1.4   [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]

    ~$ pgvm cluster list
    there is no clusters in current environment (9.1.4)

    ~$ pgvm current
    9.1.4

    ~$ pg_config --configure --version
    '--prefix=/home/user/.pgvm/environments/9.1.4'
    PostgreSQL 9.1.4

    ~$ psql --version
    psql (PostgreSQL) 9.1.4
    contains support for command-line editing

    ~$ pgvm use 8.4.11
    switched to 8.4.11

    ~$ pgvm list
    PostgreSQL Installed Version:

        PostgreSQL 8.3.19  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
     => PostgreSQL 8.4.11  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
        PostgreSQL 9.1.4   [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]

    ~$ pgvm cluster list
    there is no clusters in current environment (8.4.11)

    ~$ pgvm current
    8.4.11

    ~$ pg_config --configure --version
    '--prefix=/home/user/.pgvm/environments/8.4.11' '--enable-cassert'
    PostgreSQL 8.4.11

    ~$ psql --version
    psql (PostgreSQL) 8.4.11
    contains support for command-line editing

    ~$ pgvm cluster

    Manipulates clusters within pgvm.

    Usage: pgvm cluster <action> <args>

      - action

        create      Creates a new cluster (PGDATA)
        remove      Removes a cluster
        rename      Renames a cluster
        list        List all clusters

        import      Import a cluster from tarball
        export      Export a cluster to tarball


    ~$ pgvm cluster create test
    initializing cluster in '/home/user/.pgvm/clusters/8.4.11/test'... ok!

    ~$ pgvm cluster start test
    starting cluster test@8.4.11
    LOG:  database system was shut down at 2012-08-05 23:48:38 BRT
    LOG:  autovacuum launcher started
    LOG:  database system is ready to accept connections

    ~$ pgvm cluster list
    cluster in current enviroment (8.4.11):

        test  is online  at port 5433

    ~$ pgvm use 9.1.4
    switched to 9.1.4

    ~$ pgvm cluster list
    there is no clusters in current environment (9.1.4)

    ~$ pgvm cluster create my_cluster
    initializing cluster in '/home/user/.pgvm/clusters/9.1.4/my_cluster'... ok!

    ~$ pgvm cluster start my_cluster
    starting cluster my_cluster@9.1.4
    LOG:  database system was shut down at 2012-08-05 23:48:40 BRT
    LOG:  database system is ready to accept connections
    LOG:  autovacuum launcher started

    ~$ pgvm cluster list
    cluster in current enviroment (9.1.4):

        my_cluster  is online  at port 5434

    ~$ pgvm cluster create my_another_cluster
    initializing cluster in '/home/user/.pgvm/clusters/9.1.4/my_another_cluster'... ok!

    ~$ pgvm cluster start my_another_cluster
    starting cluster my_another_cluster@9.1.4
    LOG:  database system was shut down at 2012-08-05 23:48:42 BRT
    LOG:  autovacuum launcher started
    LOG:  database system is ready to accept connections

    ~$ pgvm cluster list
    cluster in current enviroment (9.1.4):

        my_another_cluster is online  at port 5435
        my_cluster         is online  at port 5434

    ~$ pgvm use 8.4.11
    switched to 8.4.11

    ~$ pgvm cluster list
    cluster in current enviroment (8.4.11):

        test  is online  at port 5433

    ~$ pgvm cluster stop test
    stoping cluster test@8.4.11
    LOG:  received smart shutdown request
    LOG:  autovacuum launcher shutting down
    LOG:  shutting down
    LOG:  database system is shut down
    server stopped

    ~$ pgvm use 9.1.4
    switched to 9.1.4

    ~$ pgvm cluster stop my_cluster
    stoping cluster my_cluster@9.1.4
    LOG:  received smart shutdown request
    LOG:  autovacuum launcher shutting down
    LOG:  shutting down
    LOG:  database system is shut down

    ~$ pgvm cluster stop my_another_cluster
    stoping cluster my_another_cluster@9.1.4
    LOG:  received smart shutdown request
    LOG:  autovacuum launcher shutting down
    LOG:  shutting down
    LOG:  database system is shut down

    ~$ pgvm use 9.2beta2
    switched to 9.2beta2

    ~$ pgvm list
    PostgreSQL Installed Version:

        PostgreSQL 8.3.19  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
        PostgreSQL 8.4.11  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
        PostgreSQL 9.1.4   [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]

    ~$ pgvm uninstall 9.1.4
    Removing Postgres version 9.1.4 installed and your source by pgvm!

    ~$ pgvm uninstall 8.4.11 --purge
    Removing Postgres version 8.4.11 installed and your source by pgvm!

    ~$ pgvm uninstall --all --purge
    Removing the following Postgres versions sources and installed by pgvm!

    8.3.19
    9.2beta2


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
