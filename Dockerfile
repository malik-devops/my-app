FROM node:20-bullseye
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


# Étape 2 : Nginx pour servir l'app
FROM nginx:alpine

# Copie le build généré dans nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Supprime la config par défaut et ajoute la tienne
RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d

# Expose le port 80
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]