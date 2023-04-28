FROM node AS builder
WORKDIR /app
COPY . .

RUN npm i -g install grunt
RUN npm install

RUN grunt

FROM nginx AS runner
WORKDIR /usr/share/nginx/html

ENV NODE_ENV production

COPY --from=builder /app/index.html ./index.html
COPY --from=builder /app/index.css ./index.html
COPY --from=builder /app/build/clumsy-min.js ./build/clumsy-min.js

EXPOSE 80

ENV PORT 80

CMD ["nginx", "-g", "daemon off;"]
