###
#
# Javascript port of Crypt::Pseudo
# https://github.com/CliffS/crypt-pseudo
#
# Originally ported from http://blog.kevburnsjr.com/php-unique-hash
# (Now defunct).
#
###

BigInt = require 'BigInt'

###
goldenPrimes =
  1:                  '1'
  41:                 '59'
  2377:               '1677'
  147299:             '187507'
  9132313:            '5952585'
  566201239:          '643566407'
  35104476161:        '22071637057'
  2176477521929:      '294289236153'
  134941606358731:    '88879354792675'
  8366379594239857:   '7275288500431249'
  518715534842869223: '280042546585394647'
###

goldenPrimes = [
  '1'
  '41'
  '2377'
  '147299'
  '9132313'
  '566201239'
  '35104476161'
  '2176477521929'
  '134941606358731'
  '8366379594239857'
  '518715534842869223'
]

bigint = (v, base = 10) ->
  BigInt.str2bigInt v.toString(), base

power = (big, i) ->     # big :BigInt ** i :integer
  p = bigint 1
  p = BigInt.mult big, p for [1..i] if i > 0
  p

invert = (s) ->
  s.replace /\w/g, (c) ->
    if c.match '[a-z]' then c.toUpperCase() else c.toLowerCase()

class PseudoHash

  constructor: (bits = 62) ->
    throw 'Bits must be 62 or 36' unless bits is 36 or bits is 62
    @bits = bits
    bits = bigint @bits
    @mmi = (BigInt.inverseMod bigint(k), power(bits, i) for k,i in goldenPrimes)

  hash: (num, len = 5) ->
    ceil = power bigint(@bits), len
    prime = goldenPrimes[len]
    dec = BigInt.multMod bigint(prime), bigint(num), ceil
    hash = BigInt.bigInt2str dec, @bits
    hash = "0#{hash}" while hash.length < len
    invert hash

  unhash: (hash) ->
    len = hash.length
    hash = invert hash
    ceil = power bigint(@bits), len
    mmi = @mmi[len]
    dec = bigint hash, @bits
    num = BigInt.multMod mmi, dec, ceil
    Number.parseInt BigInt.bigInt2str num, 10

module.exports = PseudoHash
