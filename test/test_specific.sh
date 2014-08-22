#!/bin/bash

. test/assert.sh

assert_raises "ls ~/spectest"

assert_end specific
