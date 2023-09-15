DEVICE_NAME="iPad Air (5th generation)"
UUID=$(cat devices.txt | sed -E 's/ \(([A-Z0-9\-]+)\) / -- (\1) /g' | grep "${DEVICE_NAME} -- " | awk -F '[()]' '{print $(NF-3)}')
echo $UUID
