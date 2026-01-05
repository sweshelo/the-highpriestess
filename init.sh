#!/bin/bash
PWD=`pwd`

# the-fool
if [ ! -e "$PWD/repo/the-fool" ]; then
  git clone https://github.com/sweshelo/the-fool repo/the-fool
fi

cd "$PWD/repo/the-fool";
git switch release
git pull origin release
cd $PWD

# the-magician
if [ ! -e "$PWD/repo/the-magician" ]; then
  git clone https://github.com/sweshelo/the-magician repo/the-magician
fi

cd "$PWD/repo/the-magician";
git switch main
git pull origin main
cd $PWD

docker compose build
