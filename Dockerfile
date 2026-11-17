FROM nginx:alpine

COPY fichier.html /usr/share/nginx/html/index.html
COPY fichier.css /usr/share/nginx/html/fichier.css

EXPOSE 80