#!/bin/bash

# Kiểm tra tham số đầu vào (chỉ cần ModuleName)
if [ $# -lt 1 ]; then
  echo "Usage: $0 <ModuleName>"
  exit 1
fi

MODULE_NAME="$1"

# Thư mục hiện tại của script
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Tạo thư mục reports nếu chưa có
mkdir -p "$CURRENT_DIR/${MODULE_NAME}/reports"

# Đường dẫn báo cáo
REPORT_PATH="$CURRENT_DIR/${MODULE_NAME}/reports/report.html"
JSON_PATH="$CURRENT_DIR/${MODULE_NAME}/reports/output.json"

# Chạy Newman (không dùng folder)
npx newman run "$CURRENT_DIR/$MODULE_NAME/$MODULE_NAME.postman_collection.json" \
  -e "$CURRENT_DIR/workspace.postman_globals.json" \
  --iteration-data "$CURRENT_DIR/$MODULE_NAME/Test Data.json" \
  --reporters cli,htmlextra,json \
  --reporter-htmlextra-export "$REPORT_PATH" \
  --reporter-json-export "$JSON_PATH" \
  --reporter-htmlextra-title "QLSVNCKH API Test Report - $MODULE_NAME" \
  --reporter-htmlextra-darkTheme \
  --reporter-htmlextra-showEnvironmentData \
  --reporter-htmlextra-logs \
  --insecure

echo "==============================="
echo "Test run completed!"
echo "HTML report: $REPORT_PATH"
echo "==============================="