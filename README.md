libledger
=========

[![Gem Version](https://img.shields.io/gem/v/libledger.svg)](https://rubygems.org/gems/libledger)
[![Dependency Status](https://img.shields.io/gemnasium/akerl/libledger.svg)](https://gemnasium.com/akerl/libledger)
[![Build Status](https://img.shields.io/circleci/project/akerl/libledger/master.svg)](https://circleci.com/gh/akerl/libledger)
[![Coverage Status](https://img.shields.io/codecov/c/github/akerl/libledger.svg)](https://codecov.io/github/akerl/libledger)
[![Code Quality](https://img.shields.io/codacy/e5360f4242b64246b2a70022616c9bea.svg)](https://www.codacy.com/app/akerl/libledger)
[![MIT Licensed](https://img.shields.io/badge/license-MIT-green.svg)](https://tldrlegal.com/license/mit-license)

Library for interacting with [Ledger](http://www.ledger-cli.org/) files.

## Usage

libledger provides Ledger::Entry, which is a transaction, and Ledger::Journal, a list of transactions.

To create a new entry:

```
require 'libledger'
require 'date'

entry = Ledger::Entry.new(
  name: 'Delicious Chipotle Burrito',
  state: :cleared,
  date: Date.today,
  actions: [
    { name: 'Expenses:Burritos', amount: '$6.89' },
    { name: 'Assets:visa' }
  ]
)

# This will print the entry in ledger format
puts entry
```

To read an entry, call `Ledger::Entry.from_lines(lines)`. `lines` should be an array of strings, which are the lines of a ledger journal for that transaction.

To read a full journal, use `Ledger::Journal.from_file(file)`, where file should be a path to the journal file. If you have multiple files, `Ledger::Journal.from_files(files)` accepts an array of paths.

To create a journal, use `Ledger::Journal.new(entries: array_of_entries)`.

The output of `.to_s` on a Journal (which is called if you do `puts my_journal` is the ledger text file format for its transactions.

## Installation

    gem install libledger

## License

libledger is released under the MIT License. See the bundled LICENSE file for details.

