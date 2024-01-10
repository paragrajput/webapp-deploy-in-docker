#stage 1 Build webapplication
FROM node:18-alpine as builder
WORKDIR /app
COPY public/ /app/public
COPY src/ /app/src
COPY package.json /app/
RUN npm install
RUN npm run build

#stage 2 Deploy in Nginx
FROM nginx
WORKDIR /usr/share/nginx/
RUN rm -rf ./html/*
COPY --from=builder /app/build ./html/ 
CMD ["nginx", "-g", "daemon off;"]