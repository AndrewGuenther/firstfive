#!/bin/bash

. test/assert.sh

assert_raises "ls example/link/oh-my-zsh"

assert_end custom
