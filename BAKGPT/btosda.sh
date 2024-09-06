#!/bin/bash
# @Author: Your name
# @Date:   2024-09-06 15:48:14
# @Last Modified by:   Your name
# @Last Modified time: 2024-09-06 16:06:52

# 检查文件是否存在
if [ ! -f "$1" ]; then
  echo "Error: File '$1' not found."
  exit 1
fi

# 逐行读取文件并执行命令
awk '{print $0}' "$1" | while read -r line; do
  echo "About to execute: '$line'"
  sh -c "$line"
  sleep 1
done