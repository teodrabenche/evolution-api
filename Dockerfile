FROM node:20-alpine AS builder

RUN apk update && \
    apk add --no-cache git ffmpeg wget curl bash openssl

WORKDIR /evolution

COPY . .

# Esto imprimirá qué hay en src antes de compilar
RUN ls -la ./src

RUN npm install

RUN npm run build

FROM node:20-alpine AS final

RUN apk update && \
    apk add --no-cache tzdata ffmpeg bash openssl

ENV TZ=America/Sao_Paulo

WORKDIR /evolution

COPY --from=builder /evolution /evolution

EXPOSE 8080

CMD ["npm", "run", "start:prod"]
