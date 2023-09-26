# build frontend from source
FROM mrinjamul/pnpm:latest as frontend

WORKDIR /usr/src/app
COPY ./SRM-frontend/package.json ./SRM-frontend/pnpm-lock.yaml ./
RUN pnpm install
ADD SRM-frontend .
RUN pnpm run build

# run production backend
FROM mrinjamul/pnpm:latest

WORKDIR /app
COPY ./SRM-backend/package.json ./SRM-backend/pnpm-lock.yaml ./
RUN pnpm install
ADD SRM-backend .
COPY --from=frontend /usr/src/app/dist /app/ui

EXPOSE 4000

CMD ["pnpm","run","start"]

