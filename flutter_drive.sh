#!/bin/bash

# Tạo named pipe
rm -rf pipe
mkfifo pipe

# Chạy flutter driver và đưa output vào named pipe
flutter drive --target=test_driver/app.dart > pipe &

# Lưu pid của flutter driver
flutter_pid=$!

# Đọc từ named pipe với awk
error=$(awk '
    /flutter: \[FlutterError\]/ { flutter_error=1; print; next }
    flutter_error && !/<…>/ { print; next }
    flutter_error && /<…>/ { print; flutter_error=0; exit 1 }
    /Todo App --/ { todo_error=1; print; next }
    todo_error && !/Invoker\._waitForOutstandingCallbacks/ { print; next }
    todo_error && /Invoker\._waitForOutstandingCallbacks/ { print; todo_error=0; exit 2 }
' < pipe)

# Chờ flutter driver hoàn thành và lấy mã trả về của nó
wait $flutter_pid
flutter_exit_code=$?

# Kiểm tra mã thoát của awk
awk_exit_code=$?

# Kiểm tra mã trả về của cả flutter driver và awk
if [ $awk_exit_code -eq 1 ] || [ $awk_exit_code -eq 2 ] || [ $flutter_exit_code -ne 0 ]; then
    rm -rf pipe
    echo "Error detected:"
    echo "$error"
    exit 1
fi

# Xóa named pipe
rm -rf pipe

