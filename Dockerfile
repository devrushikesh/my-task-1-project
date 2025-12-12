FROM nginx:trixie

RUN rm -f /usr/share/nginx/html/*.html

COPY index.html /usr/share/nginx/html/

EXPOSE 80
