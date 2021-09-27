FROM node:latest

# 작업 디렉토리 설정
RUN mkdir /frontend

#ADD . /frontend

WORKDIR /frontend

ENV PATH /frontend/node_modules/.bin:$PATH

COPY package.json /frontend/package.json
COPY yarn.lock /frontend/yarn.lock

#COPY ./package.json yarn.lock ./

# package install
RUN yarn install

# project build
#RUN yarn build

COPY . /frontend

#EXPOSE 3000
CMD ["yarn", "start"]