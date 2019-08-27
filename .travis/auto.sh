#!/bin/bash

# Some basic variables
GIT_MAIL="rapacz.mateusz@gmail.com"
GIT_USER="mateuszrapacz"
ORGANIZATION=$(echo "$TRAVIS_REPO_SLUG" | awk -F '/' '{print $1}')
PROJECT=$(echo "$TRAVIS_REPO_SLUG" | awk -F '/' '{print $2}')
GALAXY_URL="https://galaxy.ansible.com/${ORGANIZATION}/${PROJECT#ansible-}"

# Git config
git config --global user.email "${GIT_MAIL}"
git config --global user.name "${GIT_USER}"
GIT_URL=$(git config --get remote.origin.url)
GIT_URL=${GIT_URL#*//}

# Generate TAG
GIT_TAG=none
echo "Last commit message: $TRAVIS_COMMIT_MESSAGE"
case "${TRAVIS_COMMIT_MESSAGE}" in
  *"[patch]"*|*"[fix]"* )                GIT_TAG=$(git semver --next-patch) ;;
  *"[minor]"*|*"[feat]"*|*"[feature]"* ) GIT_TAG=$(git semver --next-minor) ;;
  *"[major]"*|*"[breaking change]"* )    GIT_TAG=$(git semver --next-major) ;;
  *) echo "Keyword not detected. Doing nothing" ;;
esac
if [ "$GIT_TAG" != "none" ]; then
    echo "Assigning new tag: $GIT_TAG"
    git tag "$GIT_TAG" -a -m "Generated tag from TravisCI for build $TRAVIS_BUILD_NUMBER"
    git push "https://${GH_TOKEN}:@${GIT_URL}" --tags || exit 0
fi
