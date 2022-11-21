# Pact Python FFI Demonstration

Demonstration usage of the Pact FFI Library with Python.

Based on some of the original work done by Elliot Murray and Mike Geeves

- https://github.com/pact-foundation/pact-python/pull/265
- https://github.com/pact-foundation/pact-python/pull/245

Uses the same examples as demonstrated here

- HTTP & Message Pact Examples, as shown in examples in other languages
  - https://github.com/YOU54F/pact-ruby-ffi/tree/main/spec
  - https://github.com/pact-foundation/pact-reference/blob/master/javascript/lib/simple_pact.js
  - https://github.com/pact-foundation/pact-reference/blob/master/ruby/example_consumer_spec/spec/simple_consumer_spec.rb
  - https://github.com/pact-foundation/pact-reference/blob/master/php/src/consumer-1.php
  - https://github.com/pact-foundation/pact-reference/blob/master/php/src/consumer-2.php
- Area Calculator Pact Plugin gRPC examples
  - https://github.com/pact-foundation/pact-plugins/tree/main/examples/gRPC/area_calculator
  - https://github.com/YOU54F/pact-ruby-ffi/tree/main/examples/area_calculator

## Pre Requisities

- [Python](https://www.python.org/) >=3.6 <=3.10
- [Pact FFI](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_ffi) Library for OS
  - (install with `make setup`)
- [Pact FFI](https://github.com/pact-foundation/pact-reference/tree/master/rust/pact_ffi) Header file
  - (install with `make setup`)
- [`CFFI`](https://cffi.readthedocs.io/en/latest/)
  - (install with `make install`)

## How to use

1. `make setup`
2. `make install`
3. `make run_hello_ffi`

## Steps

1. Retrieve Pact Ruby Standalone
2. Retrieve Pact FFI Binary for Platform
3. Retrieve Pact FFI Header file
4. Parse Pact FFI Header File
5. Print out Pact FFI Version

## Developer notes

## CFFI

We need to remove these lines in order to load the full header file

```sh
#ifndef pact_ffi_h
#define pact_ffi_h
#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#endif /* pact_ffi_h */
```