# Build stage
FROM node:16-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN npm run build

# Production stage
FROM node:16-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install --only=production

COPY --from=builder /usr/src/app/out ./out
COPY --from=builder /usr/src/app/swagger.yml ./swagger.yml

EXPOSE 3000

CMD ["npm", "start"]
