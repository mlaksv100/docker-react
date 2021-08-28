FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm config rm http_proxy
RUN npm config rm https_proxy
RUN npm set strict-ssl false
RUN npm install
COPY . .
RUN npm run build

FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

