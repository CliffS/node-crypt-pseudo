# node-pseudhash

[issues]: https://github.com/CliffS/node-pseudohash/issues

## Short, reversable, alphanumeric pseudohash with hard-to-guess sequence.

This is designed to generate a string from a number so
that it can be displayed to a user without similar numbers
being easy to guess.  It is generally used in creating URLs
that map to IDs.

This code was ported from my Perl module at
<https://github.com/CliffS/crypt-pseudo>.  The code was originally
ported from the PHP at <http://blog.kevburnsjr.com/php-unique-hash>
(now defunct).

## Install

    npm install pseudohash

## Usage

    assert = require('assert');
    Pseudo = require('pseudohash');
    var pseudo = new Pseudo(62);

    var number = Math.random() * 100000;
    var hash = pseudo.hash(number, 5);
    console.log(hash);

    var newnum = pseudo.unhash(hash);
    assert.equal(newnum, number);

The `new Pseudo()` command creates a "factory" for generating
pseudo-hashes.  Yuo can choose between 62 bit hashes (using
A to Z, a to z, 0 to 9) and 36 bit hashes (using upper-case
letters and digits only).  It defaults to 62 bits if no value
is passed.

The `hash()` routine can be passed a `length`.  This is the
length of the resulting pseudo-hash, defaulting to 5.

The precision depends on the number of bits and the length
of the pseudo-hash.

Using the defaults of 62 bits and a string length of 5,
the maximum number that can be encrypted is 916,132,831.

With 32 bits (lower case only) the maximum for 5 characters 
is 60,466,175.

With 32 bits and a 6 character string, the maximum is 2,176,782,335.

Please let me know if you find this useful.  Any issues or
comments would be appreciated at [Github][issues].
