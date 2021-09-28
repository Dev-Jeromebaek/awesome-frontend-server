# build environment
FROM node:current-alpine3.11 as builder

# 작업 폴더를 만들고 npm 설치
RUN mkdir /srv/frontend
WORKDIR /srv/frontend
ENV PATH /srv/frontend/node_modules/.bin:$PATH
COPY app/package.json /srv/frontend/package.json
RUN yarn install

# 소스를 작업폴더로 복사하고 빌드
COPY app /srv/frontend
RUN yarn build


# production environment
FROM nginx:1.21.3-alpine

# 위에서 생성한 앱의 빌드산출물을 nginx의 샘플 앱이 사용하던 폴더로 이동
COPY --from=builder /srv/frontend/build /usr/share/nginx/html
# nginx의 기본 설정을 삭제하고 앱에서 설정한 파일을 복사
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

# 80포트 오픈하고 nginx 실행
# EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
