#!/bin/bash

git log --oneline $(git describe --abbrev=0 --tags --exclude '*-rollback'  $(git rev-list --tags --skip=1 --max-count=1))..$(git describe --abbrev=0 --tags --exclude '*-rollback')


