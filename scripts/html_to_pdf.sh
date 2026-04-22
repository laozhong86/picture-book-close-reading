#!/usr/bin/env bash
# html_to_pdf.sh — 把 HTML 渲染成 A4 PDF。
# 用法: ./html_to_pdf.sh <input.html> [<output.pdf>]
# 若省略 output，自动用同名 .pdf 后缀。
# 退出码：0=成功；1=入参错；2=找不到渲染器；3=渲染失败。

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: $0 <input.html> [<output.pdf>]" >&2
  exit 1
fi

input="$1"
output="${2:-${input%.html}.pdf}"

if [[ ! -f "$input" ]]; then
  echo "error: input not found: $input" >&2
  exit 1
fi

# 按优先级尝试渲染器
CHROME_MAC="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
CHROMIUM_MAC="/Applications/Chromium.app/Contents/MacOS/Chromium"
EDGE_MAC="/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge"

renderer=""
for candidate in "$CHROME_MAC" "$CHROMIUM_MAC" "$EDGE_MAC"; do
  if [[ -x "$candidate" ]]; then renderer="$candidate"; break; fi
done
if [[ -z "$renderer" ]]; then
  for cli in chromium google-chrome chrome; do
    if command -v "$cli" >/dev/null 2>&1; then renderer="$(command -v "$cli")"; break; fi
  done
fi

if [[ -z "$renderer" ]]; then
  echo "error: no Chromium-based browser found" >&2
  echo "hint: install Chrome (https://google.com/chrome) or 'brew install --cask chromium'" >&2
  exit 2
fi

# 绝对路径 + file:// URL（file:// 对空格/中文更稳）
abs_in="$(cd "$(dirname "$input")" && pwd)/$(basename "$input")"
file_url="file://$abs_in"

"$renderer" \
  --headless=new \
  --disable-gpu \
  --no-pdf-header-footer \
  --print-to-pdf-no-header \
  --print-to-pdf="$output" \
  "$file_url" 2>/dev/null || { echo "error: render failed" >&2; exit 3; }

if [[ ! -s "$output" ]]; then
  echo "error: output PDF is empty" >&2
  exit 3
fi

echo "$output"
