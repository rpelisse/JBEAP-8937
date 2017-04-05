#!/bin/bash

readonly WILDFLY_GITHUB_URL=${WILDFLY_GITHUB_URL:-'https://github.com/wildfly/wildfly.git'}

git clone "${WILDFLY_GITHUB_URL}" wildfly.git
cd wildfly.git

export MAVEN_REPO_LOCAL=${MAVEN_REPO_LOCAL:-'local-maven-repository'}
bash -x  ./build.sh -B -llr -Dmaven.repo.local=${MAVEN_REPO_LOCAL} -fae -DskipTests

