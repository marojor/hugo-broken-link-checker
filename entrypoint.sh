#!/usr/bin/env sh
echo "Starting Hugo server..."

cd $GITHUB_WORKSPACE
hugo server --baseUrl http://localhost:1313 > /tmp/hugo.output &
HUGO_PID=$!
sleep 1

# Wait for Hugo to finish the startup process
tail -f /tmp/hugo.output | grep -qe 'Press Ctrl+C to stop'
echo "Hugo has started"

linkchecker linkchecker http://localhost:1313 --output failures
LINK_CHECKER_RESULT=$?

kill $HUGO_PID
exit $LINK_CHECKER_RESULT
