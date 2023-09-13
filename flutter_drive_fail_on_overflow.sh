# #!/bin/bash

# # Thực thi Flutter Driver và kiểm tra logs ngay lập tức
# error=$(flutter drive --target=test_driver/app.dart | tee test_logs.log | awk '
#     /flutter: \[FlutterError\]/ { print; flag=1; next }
#     flag && !/<…>/ { print }
#     flag && /<…>/ { print; flag=0; exit 1 }
# ')

# # Kiểm tra exit code của awk
# if [ $? -eq 1 ]; then
#     echo "Error detected:"
#     echo "$error"
#     exit 1
# fi

###########################################
#!/bin/bash

# Tạo named pipe
mkfifo pipe

# Chạy flutter driver và đưa output vào named pipe
flutter drive --target=test_driver/app.dart > pipe &

# Lưu pid của flutter driver
flutter_pid=$!

# Đặt trap để dừng flutter driver khi script kết thúc
trap "kill $flutter_pid 2> /dev/null" EXIT

# Đọc từ named pipe với awk
error=$(awk '
    /flutter: \[FlutterError\]/ { print; flag=1; next }
    flag && !/<…>/ { print }
    flag && /<…>/ { print; flag=0; exit 1 }
' < pipe)

# Kiểm tra exit code của awk
awk_exit_code=$?

# Nếu awk đã thoát với mã 1 (phát hiện lỗi), in lỗi và dừng script
if [ $awk_exit_code -eq 1 ]; then
    echo "Error detected:"
    echo "$error"
    exit 1
fi

# Xóa named pipe
rm -rf pipe
