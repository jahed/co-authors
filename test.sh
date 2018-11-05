#!/usr/bin/env bash
set -eo pipefail

function prepare_case {
  rm -rf .test-git-repo
  cp -r test-git-repo-template .test-git-repo
  cd .test-git-repo
  git init
  yarn install
  yarn link @jahed/co-authors
  git add .
}

function test_case {
  local TEST_CASE=${1}
  local INPUT=${2}
  local EXPECTED=${3}

  echo
  echo "[TEST] ${TEST_CASE}"
  echo "=================================="

  prepare_case
  git commit -m "${INPUT}"
  ACTUAL=$(git log -1 --pretty=%B)

  if [[ "${ACTUAL}" != "${EXPECTED}" ]]; then
    echo
    echo "Expected:"
    echo "----------------------------------"
    echo "${EXPECTED}"
    echo "----------------------------------"
    echo
    echo "Actual:"
    echo "----------------------------------"
    echo "${ACTUAL}"
    echo "----------------------------------"
    echo
    echo "[FAIL] ${TEST_CASE}"
    exit 1
  fi

  echo "[PASS] ${TEST_CASE}"
}

function should_replace_co_authors {
  local INPUT=$(cat <<EOF
test commit

Co-Authored-By: Jahed
Co-Authored-By: Bob
EOF
)

  local EXPECTED=$(cat <<EOF
test commit

Co-Authored-By: Jahed Ahmed <jahed@fake.email>
Co-Authored-By: Bob <bob@fake.email>
EOF
)

  test_case "should replace co authors" "${INPUT}" "${EXPECTED}"
}

echo "Running tests."

yarn link
cd tests

should_replace_co_authors

echo "Tests passed."
