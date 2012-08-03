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

	~$ pgvm install 9.1.4
    downloading 'http://ftp.postgresql.org/pub/source/v9.1.4/postgresql-9.1.4.tar.gz', please be patient... done.
    checking 'postgresql-9.1.4.tar.gz' integrity... done.
    extracting postgresql-9.1.4.tar.gz ... done.
    configuring PostgreSQL Version: 9.1.4 ... done.
    compiling ... done.
    installing ... done.

    ~$ MAKE_OPTS="-j 16" CONFIG_OPTS="--enable-cassert" pgvm install 8.4.11
    downloading 'http://ftp.postgresql.org/pub/source/v8.4.11/postgresql-8.4.11.tar.gz', please be patient... done.
    checking 'postgresql-8.4.11.tar.gz' integrity... done.
    extracting postgresql-8.4.11.tar.gz ... done.
    configuring PostgreSQL Version: 8.4.11 ... done.
    compiling ... done.
    installing ... done.

    ~$ pgvm use 9.1.4
    ~$ pgvm list
    PostgreSQL Installed Version:

        PostgreSQL 8.4.11  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
     => PostgreSQL 9.1.4   [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]

    ~$ pgvm current
    9.1.4

    ~$ pgvm use 8.4.11
    ~$ pgvm current
    8.4.11

    ~$ pg_config --configure --version
    '--prefix=/home/user/.pgvm/environments/8.4.11' '--enable-cassert'
    PostgreSQL 8.4.11

    ~$ psql --version
    psql (PostgreSQL) 8.4.11
    contains support for command-line editing

    ~$ pgvm use 9.1.4
    ~$ pgvm current
    9.1.4

    ~$ psql --version
    psql (PostgreSQL) 9.1.4
    contains support for command-line editing

    ~$ pgvm cluster create test
    initializing cluster in '/home/user/.pgvm/clusters/9.1.4/test'... ok!

    ~$ pgvm cluster create replica
    initializing cluster in '/home/user/.pgvm/clusters/9.1.4/replica'... ok!

    ~$ pgvm cluster list
    cluster in current enviroment (9.1.4):

    replica
    test

    ~$ pgvm cluster start replica
    server starting
    LOG:  database system is ready to accept connections

    ~$ pgvm cluster start test
    server starting
    LOG:  database system is ready to accept connections

    ~$ netstat -anp | grep postgres | grep "LISTEN "
    tcp        0      0 127.0.0.1:5433          0.0.0.0:*               LISTEN      24219/postgres
    tcp        0      0 127.0.0.1:5434          0.0.0.0:*               LISTEN      24199/postgres


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
