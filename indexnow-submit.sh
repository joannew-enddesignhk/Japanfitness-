#!/usr/bin/env bash
# IndexNow URL submission for Bing, Yandex, Naver and partner engines.
# Usage: ./indexnow-submit.sh [optional-host]

set -euo pipefail

HOST="${1:-www.wafufitness.com}"
KEY="a7f3c9e2b1d8406f"
KEY_LOCATION="https://${HOST}/${KEY}.txt"

python3 - <<PY | curl -s -w "\nHTTP %{http_code}\n" \
  -X POST "https://api.indexnow.org/IndexNow" \
  -H "Content-Type: application/json; charset=utf-8" \
  -d @-
import json
host = "${HOST}"
key = "${KEY}"
urls = [
    f"https://{host}/",
    f"https://{host}/index.html",
    f"https://{host}/about.html",
    f"https://{host}/classes.html",
    f"https://{host}/membership.html",
    f"https://{host}/contact.html",
    f"https://{host}/blog/",
    f"https://{host}/blog/winter-training-tips.html",
    f"https://{host}/blog/martial-arts-fitness-benefits.html",
]
print(json.dumps({
    "host": host,
    "key": key,
    "keyLocation": f"https://{host}/{key}.txt",
    "urlList": urls
}, ensure_ascii=False))
PY
