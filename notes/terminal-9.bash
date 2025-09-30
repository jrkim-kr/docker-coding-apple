# 1. Nginx 이미지 빌드
docker build -t nginx:v1 ./nginx

# 2. 웹서버 컨테이너 실행 (mynet1 네트워크에 연결)
docker run -d -p 8080:8080 --network mynet1 --name server-container nodeserver:v1

# 3. Nginx 컨테이너 실행 (mynet1 네트워크에 연결)
docker run -d -p 80:80 --network mynet1 --name nginx-container nginx:v1

# 4. 설정 수정 후 Nginx 재빌드
docker build -t nginx:v1 ./nginx

# 5. 기존 컨테이너 정리 (강의에는 도커 데스크톱에서 직접 삭제했지만 터미널로 하면 재실행 전 추가 필요)
docker rm -f server-container nginx-container

# 6. 웹서버 컨테이너 재실행
docker run -d -p 8080:8080 --network mynet1 --name server-container nodeserver:v1

# 7. Nginx 컨테이너 재실행
docker run -d -p 80:80 --network mynet1 --name nginx-container nginx:v1