# build stage
FROM node:lts-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# production stage
FROM nginx:stable-alpine as production-stage
EXPOSE 3002
COPY --from=build-stage /app /var/www/vuejs-app
# ADD ./certs/ /etc/nginx/certs/mkcert
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
# CMD ["nginx", "-g", "daemon off;"]