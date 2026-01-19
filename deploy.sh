#!/bin/bash

set -e
echo "1. 프로젝트 폴더로 이동"
export PATH="$HOME/.local/bin:$PATH"

echo "2. 최신 코드 pull"
git pull origin main

echo "3. 기존 uvicorn 프로세스 종료"
if [ -f app.pid ]; then
  PID=$(cat app.pid)
  if ps -p $PID > /dev/null; then
    echo "Stopping process $PID"
    kill $PID
  fi
  rm -f app.pid
else
  echo "No PID file found"
fi

uv sync

echo "4. 서버 백그라운드 실행"
nohub uv run uvicorn main:app --host 0.0.0.0 --port 8000 \ > /dev/null 2>&1 < /dev/null &

echo $! > app.pid

echo "FastAPI server started with PID: $(cat app.pid)"