PostgreSQL Version Manager - pgvm
==================================

PostgreSQL Version Manager, or simply `pgvm` is a tool to manage multiple PostgreSQL installations.

Installation
------------

To install just type:

    curl -s -L https://raw.github.com/guedes/pgvm/master/bin/pgvm-self-install | bash

Then open a new terminal or type:

    source ~/.bashrc

and voila!


Depends
-------

  `pvgm` has the following dependenies:

  * `bash`
  * `c compiler`
  * `gmake`
  * `readline`
  * `zlib`
  * `git` in order to get PostgreSQL trunk version.

Usage
-----

    $ pgvm help
    Usage: pgvm action [arguments]

    - actions:

      install      Installs a specific PostgreSQL version
      uninstall    Uninstalls a specific PostgreSQL version

      list         List all installed PostgreSQL versions
      use          Choose an enviroment to use

      help         This help

An example session
------------------

    ~$ pgvm

    Usage: pgvm action [arguments]

      - actions:

        install      Installs a specific PostgreSQL version
        uninstall    Uninstalls a specific PostgreSQL version

        list         List all installed PostgreSQL versions
        use          Choose an enviroment to use

        help         This help

    ~$ pgvm list
    PostgreSQL Installed Version:

        PostgreSQL 8.4.11  [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]
     => PostgreSQL 9.1.3   [ ELF 64-bit LSB executable, x86-64, version 1 (SYSV) ]

    ~$ pgvm current
    9.1.3

    ~$ pgvm use 8.4.11
    ~$ pgvm current
    8.4.11

    ~$ psql --version
    psql (PostgreSQL) 8.4.11
    contains support for command-line editing

    ~$ pgvm use 9.1.3
    ~$ pgvm current
    9.1.3

    ~$ psql --version
    psql (PostgreSQL) 9.1.3
    contains support for command-line editing

TODO
----

* A PostgreSQL (un)installation task
* A list task
* A self installer


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
