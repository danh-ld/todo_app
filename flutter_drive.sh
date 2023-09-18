#!/bin/bash

# create named pipe
uuid=$1 #id of device
rm -rf pipe-${uuid}
mkfifo pipe-${uuid}

# run flutter driver and output to named pipe
flutter drive --target=test_driver/app.dart -d ${uuid} > pipe-${uuid} &

# savw pid of flutter driver
flutter_pid=$!

# read form từ named pipe with awk
error=$(awk '
    /flutter: \[FlutterError\]/ { flutter_error=1; print; next }
    flutter_error && !/<…>/ { print; next }
    flutter_error && /<…>/ { print; flutter_error=0; exit 1 }
    /Todo App --/ { todo_error=1; print; next }
    todo_error && !/Some tests failed/ { print; next }
    todo_error && /Some tests failed/ { print; todo_error=0; exit 2 }
' < pipe-${uuid})

# wait flutter driver finish and get exit code
wait $flutter_pid
flutter_exit_code=$?
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# get awk exit code
awk_exit_code=$?

# check awk exit code && flutter exit code
if [ $awk_exit_code -eq 1 ] || [ $awk_exit_code -eq 2 ] || [ $flutter_exit_code -ne 0 ]; then
    rm -rf pipe-${uuid}
    echo -e "${RED}✘ Error detected:${NC}"
    echo "$error"
    exit 1
fi

echo -e "${GREEN}✓ All testcases passed:${NC}"
# del named pipe
rm -rf pipe-${uuid}

