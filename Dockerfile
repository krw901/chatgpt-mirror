FROM node:18

WORKDIR /app

COPY package.json ./
COPY pnpm-lock.yaml ./
RUN corepack enable --install-directory=/usr/bin \
    && corepack prepare --activate pnpm@latest
RUN pnpm install --frozen-lockfile
COPY . .

EXPOSE 3000

CMD ["npm", "run", "start"]