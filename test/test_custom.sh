#!/bin/bash

. test/assert.sh

assert_raises "ls ~/customtest"

assert_end custom
