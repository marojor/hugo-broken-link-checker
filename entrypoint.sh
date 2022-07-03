#!/bin/bash -x
echo "Starting Hugo server..."

git config --global --add safe.directory $GITHUB_WORKSPACE

cd $GITHUB_WORKSPACE
hugo server --baseUrl http://localhost:1313 | tee /tmp/hugo.output &
HUGO_PID=$!
sleep 1

# Wait for Hugo to finish the startup process
tail -f /tmp/hugo.output | timeout 120 grep -qe 'Press Ctrl+C to stop'
echo "Hugo has started"

SKIP_FILE=$INPUT_SKIP_FILE
SKIP_FILE_OPTION=""
test -f "$SKIP_FILE" && SKIP_FILE_OPTION="--skip-file ${GITHUB_WORKSPACE}/${SKIP_FILE}"

linkcheck http://localhost:1313 $SKIP_FILE_OPTION
LINK_CHECKER_RESULT=$?

kill $HUGO_PID

exit $LINK_CHECKER_RESULT
