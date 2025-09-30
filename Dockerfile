# Étape 1 : Build
FROM node:18-alpine AS build

# Crée le dossier de travail
WORKDIR /app

# Copie les fichiers de config et installe les dépendances
COPY package*.json ./
RUN npm install

# Copie le reste du code et build
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