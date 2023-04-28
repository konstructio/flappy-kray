FROM node AS builder
WORKDIR /app
COPY . .

RUN npm i -g install grunt
RUN npm install

RUN grunt

FROM nginx AS runner
WORKDIR /usr/share/nginx/html

ENV NODE_ENV production

COPY --from=builder /app/build/ ./build/
COPY --from=builder /app/data/ ./data/
COPY --from=builder /app/js/ ./js/
COPY --from=builder /app/index.html ./index.html
COPY --from=builder /app/index.css ./index.css

EXPOSE 80

ENV PORT 80

CMD ["nginx", "-g", "daemon off;"]
