#!/usr/bin/env bash
# Copyright 2009-2017 Ram Rachum.
# This program is distributed under the MIT license.

set -e
#set -v

temp_folder=$(mktemp -d)
echo Using temp folder $temp_folder
trap "rm -rf $temp_folder" EXIT

cd $temp_folder
git init foo
cd foo
touch first
git add first && git commit -m "first"
touch second
git add second && git commit -m "second"
touch third
git add third && git commit -m "third"
touch fourth
git add fourth && git commit -m "fourth"

echo Running test 1
touch to_first_0
git-past-amend 3
git show HEAD~3 | grep to_first_0
git rev-list --format=%B --max-count=1 HEAD | grep fourth

echo Running test 2
touch to_first_1
git-past-amend HEAD~3
git show HEAD~3 | grep to_first_1
git rev-list --format=%B --max-count=1 HEAD | grep fourth

echo Running test 3
touch to_second_0
git-past-amend 2
git show HEAD~2 | grep to_second_0
git rev-list --format=%B --max-count=1 HEAD | grep fourth

echo Running test 4
git branch lala HEAD~2
touch to_second_1
git-past-amend lala
git show HEAD~2 | grep to_second_1
git rev-list --format=%B --max-count=1 HEAD | grep fourth


touch joker

echo Running test 5
if (git-past-amend 21) ; then
    echo "This should fail"
    exit 1
fi

echo Running test 6
if (git-past-amend) ; then
    echo "This should fail"
    exit 1
fi

echo Running test 7
git add joker
if (git-past-amend 2) ; then
    echo "This should fail"
    exit 1
fi

echo Running test 8
git rm --cached joker
git-past-amend 1
git show HEAD~1 | grep joker
git rev-list --format=%B --max-count=1 HEAD | grep fourth
git rev-list --format=%B --max-count=1 HEAD~3 | grep first



Echo "All tests succeeded!"

