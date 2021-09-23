#####################
# Build Environment #
#####################
FROM node:alpine AS build

WORKDIR /app

COPY package.json .
RUN npm i

COPY . .
RUN npm run build

##########################
# Production Environment #
##########################
FROM nginx:alpine AS deploy

WORKDIR /usr/share/nginx/html

RUN rm -rf ./*

COPY --from=build /app/build .

ENTRYPOINT ["nginx", "-g", "daemon off;"]

