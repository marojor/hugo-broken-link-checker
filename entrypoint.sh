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

SKIP_FILE=$1
SKIP_FILE_OPTION=""
test -f "$SKIP_FILE" && SKIP_FILE_OPTION="--skip-file ${GITHUB_WORKSPACE}/${SKIP_FILE}"

CHECK_ANCHORS=$2
CHECK_ANCHORS_OPTION=""
test "$CHECK_ANCHORS" = "false" && CHECK_ANCHORS_OPTION="--no-check-anchors"

linkcheck http://localhost:1313 $SKIP_FILE_OPTION $CHECK_ANCHORS_OPTION
LINK_CHECKER_RESULT=$?

kill $HUGO_PID

exit $LINK_CHECKER_RESULT
