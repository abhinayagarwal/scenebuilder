#!/bin/bash

if [ "${TRAVIS_OS_NAME}" = "linux" ]; then 
  ./gradlew check shadowJar -PVERSION=${TRAVIS_TAG};
else
  # Skip tests that fail on osx without xvfb
  ./gradlew check shadowJar -PVERSION=${TRAVIS_TAG} -PexcludeTests="FXOMSaverUpdateImportInstructionsTest,StaticLoadTest,SkeletonBufferTest";  
fi

# Check if tag is present and run build script
if [ -n "${TRAVIS_TAG}" ]; then
  export VERSION=${TRAVIS_TAG};
  chmod +x .ci/${TRAVIS_OS_NAME}.sh;
  sh .ci/${TRAVIS_OS_NAME}.sh;
fi