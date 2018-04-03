#!/bin/zsh

source /usr/local/bin/virtualenvwrapper.sh

alias dbg='export LD_LIBRARY_PATH=/dbg/lib; echo use ld path: $LD_LIBRARY_PATH'
alias dbg32='export LD_LIBRARY_PATH=/dbg/lib32; echo use ld path: $LD_LIBRARY_PATH'

export PYTHONIOENCODING=utf-8
