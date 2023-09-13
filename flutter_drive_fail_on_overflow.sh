#!/bin/bash

# Thực thi Flutter Driver và lưu logs
flutter drive --target=test_driver/app.dart | tee test_logs.log | awk '/EXCEPTION CAUGHT BY RENDERING LIBRARY/ { exit 1 }'

# Kiểm tra xem log có chứa "EXCEPTION CAUGHT BY RENDERING LIBRARY" hay không
if grep -q "EXCEPTION CAUGHT BY RENDERING LIBRARY" test_logs.log; then
    echo "Error detected!"
    exit 1
fi
