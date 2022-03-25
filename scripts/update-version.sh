#!/bin/bash

git=$(sh /etc/profile; which git)

LATEST_TAG=$(git describe --tags --match 'v*')
echo $LATEST_TAG
if [[ $LATEST_TAG =~ (^v[0-9]+.[0-9]+.[0-9]+-rollback.+$) ]]; then
    # Ignore the Tag with '-rollback' if this is not master branch
    LATEST_TAG=$(git describe --tags --match 'v*' --exclude '*-rollback')
elif [[ $LATEST_TAG =~ (^v[0-9]+.[0-9]+.[0-9]+-rollback$) ]]; then
    # Master branch - rollback
    LATEST_TAG=${LATEST_TAG%"-rollback"}
fi

echo $LATEST_TAG
