#!/bin/bash
set -e

# check evironment
if [ "${MYTESTIP_1}x" == "x" ] || [ "${MYTESTIP_2}x" == "x" ] || [ "${MCAST_ADDR}x" == "x" ] ; then
   echo "Env prop is missing, check the slave configuration."
   exit 1
fi


unzip -q "${HUDSON_STATIC_ENV}/eap/${EAP_VERSION}/jboss-eap-${EAP_VERSION}-src.zip"
cd "jboss-eap-${EAP_VERSION:0:3}-src"
WORKSPACE=$(pwd)
unzip -q "${HUDSON_STATIC_ENV}/eap/${EAP_VERSION}/jboss-eap-${EAP_VERSION}-testsuite-local-repository.zip"
export MAVEN_REPO_LOCAL="${WORKSPACE}/eap-local-maven-repository"

# build EAP and testsuite using OOB build scripts
bash -x  ./build.sh -B -llr -Dmaven.repo.local=${MAVEN_REPO_LOCAL} -fae -DskipTests
bash -x  ./integration-tests.sh -B -llr -Dmaven.repo.local=${MAVEN_REPO_LOCAL} -fae -DskipTests
