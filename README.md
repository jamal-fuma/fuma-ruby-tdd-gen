GenTDD
=======

# Introduction

## Overview
GenTDD is a tool for generating ruby test suites.

## Usage
./gen.sh suite-name testclass-name-1 .. testclass-name-n

### Test Cases
Test cases are ruby files.
The relevant environment variable is GEN\_TEST\_CASE which defaults to "./scripts/gen-test-case.sh"

### Test Suites
Test suites are ruby file which include one or more test cases.
The relevant environment variable is GEN\_TEST\_SUITE which defaults to "./scripts/gen-test-suite.sh"

#### Method of operation
GenTDD is a shell script which will generate file names for test cases / test suites.
It will then run a script to populate the files.
