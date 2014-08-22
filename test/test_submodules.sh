#!/bin/bash

. test/assert.sh

assert_raises "ls firstfive/link/oh-my-zsh"

assert_end submodule
