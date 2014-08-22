#!/bin/bash

. test/assert.sh

assert_raises "ls ~/.oh-my-zsh"
assert_raises "ls ~/.linkdirtest"
assert_raises "ls ~/.linkfiletest"

assert_end link
