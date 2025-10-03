# Étape 1 : build
FROM node:20-bullseye AS build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

ARG VITE_ENV=production

# Si tu veux choisir entre build:development et build:production
RUN if [ "$VITE_ENV" = "development" ]; then \
      npm run build:development ; \
      if [ "$VITE_ENV" = "production" ]; then \
      npm run build:production ; \
    else \
      npm run build
    fi
# Étape 2 : nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

