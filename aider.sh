#!/bin/bash

invoke() {
    LAST_COMMAND=("$@")
    echo "$(printf "%q " "$@")" >&2
    LAST_COMMAND_EXITCODE=0
    "$@"
    LAST_COMMAND_EXITCODE="$?"
    return $LAST_COMMAND_EXITCODE
}

if [ ! -d .venv ] ; then
    invoke python3 -m venv .venv
fi

echo source .venv/bin/activate >&2
source .venv/bin/activate

invoke aider \
    $(find . \( -iname ".venv" -prune \) -o \( \
        \(  -iname .gitignore \
        -o  -iname requirements.txt \
        -o  -iname Pipfile \
        -o  -iname "*.sh" \
        -o  -iname "*.py" \
        -o  -iname "*.yaml" \
        -o  -iname "*.adoc" \
    \) -print \) )
