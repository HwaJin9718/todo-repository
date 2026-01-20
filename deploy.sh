# !/bin/bash
# 해당 파일은 cd ~ 로 이동해서 vi deploy.sh 진행
# cd ~ : 명령어 입력 시 /home/ubuntu로 이동함

# 강사님 버전
cd /home/ubuntu/workspace/todo-repository
git pull origin main
pkill -f "uvicorn main:app" # or pkill uvicorn

# uvicorn이 종료되는데 시간 소요, 5초 sleep 했다가 fastapi 다시 시작
sleep 5 

nohup uv run uvicorn main:app --host 0.0.0.0 --port 8000 \
  > /dev/null 2>&1 < /dev/null &

# set -e
# echo "1. 프로젝트 폴더로 이동"
# export PATH="$HOME/.local/bin:$PATH"

# echo "2. 최신 코드 pull"
# git pull origin main


# echo "3. 기존 uvicorn 프로세스 종료"
# if [ -f app.pid ]; then
#   PID=$(cat app.pid)
#   if ps -p $PID > /dev/null; then
#     echo "Stopping process $PID"
#     kill $PID
#   fi
#   rm -f app.pid
# else
#   echo "No PID file found"
# fi

# uv sync

# echo "4. 서버 백그라운드 실행"
# nohup uv run uvicorn main:app --host 0.0.0.0 --port 8000 > /dev/null 2>&1 < /dev/null &

# echo $! > app.pid

# echo "FastAPI server started with PID: $(cat app.pid)"