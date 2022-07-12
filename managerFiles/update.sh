#!/bin/bash

function create_new_branch() {
  branch=$1
  git checkout -b $branch
  git push --set-upstream origin $branch
}

function update() {
  branch=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
  git add .
  git commit -m $1
  git push --set-upstream origin $branch
}

function switch_branch() {
  branch=$1
  git checkout $branch
  git push --set-upstream origin $branch
}

function delete_branch() {
  branch=$1
  git push origin --delete $branch
}

function merge_branch() {
  switch_branch $1
  branch=$2
  git merge $branch
}