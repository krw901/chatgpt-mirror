FROM node:18-slim

WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml ./
RUN corepack enable --install-directory=/usr/bin \
    && corepack prepare --activate pnpm@latest
RUN pnpm install --frozen-lockfile --prod
COPY . .
RUN pnpm run build

# runtime image
FROM node:18-slim

ENV TZ="Asia/Shanghai"

WORKDIR /app
COPY --from=0 /app/package.json .
COPY --from=0 /app/node_modules ./node_modules
COPY --from=0 /app/dist .

EXPOSE 3000

CMD ["node", "main.js"]
