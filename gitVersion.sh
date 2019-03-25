#!/bin/bash

GV=$(git describe 2> /dev/null) # must have tag.
if [ $? != 0 ]; then
    GV=g$(git rev-parse --short=7 HEAD)
    # echo "aaaa"
    if [ $? != 0 ]; then
        echo "The directory isn't controled by git!"
        GV="NotInGit"
    fi
    GV=${GV:1}
fi
if [ $GV != "NotInGit" ]; then
    GIT_STATE=$(git status 2> /dev/null | tail -n1)
    # echo $GIT_STATE
    if [[ $GIT_STATE =~ nothing.to.commit.* ]]; then
        BRANCH_STATE="0"
    else
        BRANCH_STATE="1"
    fi
fi
GV=${GV}.${BRANCH_STATE}
echo -n $GV
