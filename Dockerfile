FROM node:18 as build-stage

WORKDIR /app

COPY ./myapp/package*.json ./

RUN yarn install

COPY ./myapp .

RUN yarn build

FROM nginx:stable-alpine as production-stage

COPY --from=build-stage /app/dist /usr/share/nginx/html

COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]