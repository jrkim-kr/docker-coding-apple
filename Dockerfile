# Node.js 버전 22의 slim 이미지를 기본 이미지로 사용
# slim 버전은 불필요한 패키지들이 제거된 경량화된 이미지
FROM node:22-slim

# 컨테이너 내부의 작업 디렉토리를 /app으로 설정
# 이후 모든 명령어는 이 디렉토리에서 실행됨
WORKDIR /app

# package.json과 package-lock.json 파일을 컨테이너로 복사
# 와일드카드(*)를 사용하여 두 파일 모두 복사 (package-lock.json이 없어도 에러 없음)
# 점(.)은 현재 작업 디렉토리(/app)를 의미
COPY package*.json .

# npm ci 명령을 실행하여 package-lock.json 기반으로 정확한 버전의 의존성 설치
# JSON 배열 형태로 작성하여 셸을 거치지 않고 직접 실행 (exec form)
# ci는 Continuous Integration의 약자로 빌드 환경에 최적화됨
RUN ["npm", "ci"]

# 환경변수를 production으로 설정
# Express 등의 라이브러리가 프로덕션 모드로 동작하여 성능 향상
ENV NODE_ENV=production

# 현재 디렉토리의 모든 파일과 폴더를 컨테이너의 /app 디렉토리로 복사
# 소스코드는 package.json보다 자주 변경되므로 나중에 복사하여 캐시 활용
COPY . .

# 컨테이너가 8080 포트를 사용한다고 문서화
# 실제로 포트를 열지는 않고, 단순히 메타데이터로 기록
EXPOSE 8080

# 실행 사용자를 node로 변경 (보안을 위해 root 권한 대신 일반 사용자 권한 사용)
# node 이미지에는 이미 'node' 사용자가 생성되어 있음
USER node

# 컨테이너가 시작될 때 실행할 기본 명령어를 설정
# node server.js 명령으로 서버 애플리케이션을 실행
CMD ["node", "server.js"]
