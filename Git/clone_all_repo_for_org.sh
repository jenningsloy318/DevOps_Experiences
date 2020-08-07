#!/bin/bash
echo -e "Getting all repos for the org.\n"
TOKEN=xxxx
REMOTE_REPO_URLS=$(curl -H "Authorization: token $TOKEN" -H "Accept: application/vnd.github.v3.full+json"  -s 'https://api.github.com/orgs/LeetCodeCollections/repos'  |jq -r .[].ssh_url)
PWD=$(pwd)
echo -e "Totally `echo -e $REMOTE_REPO_URLS|wc -w ` will be processed!\n"
for repo in $REMOTE_REPO_URLS
do
  echo -e "Processing Repo $repo ..."
  cd $PWD
  REPO_NAME=$(echo $repo| awk -F"/" '{print $NF}'|awk -F"." '{print $1}')

  if [ -d $REPO_NAME ]; then

    cd $REPO_NAME && git pull  && cd ..
  else
    cd $PWD && git clone $repo
  fi
  echo -e "\n"
done