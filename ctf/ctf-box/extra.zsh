#!/bin/zsh

antigen bundles <<EOF
    adb
    brew
    copydir
    copyfile
    cp
    jsontools
    pip
    urltools
EOF

source /usr/local/bin/virtualenvwrapper.sh

alias dbg64='export LD_LIBRARY_PATH=/dbg64/lib; echo use ld path: $LD_LIBRARY_PATH'
alias dbg32='export LD_LIBRARY_PATH=/dbg32/lib; echo use ld path: $LD_LIBRARY_PATH'

export PYTHONIOENCODING=utf-8
