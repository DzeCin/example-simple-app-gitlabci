FROM nginx
RUN rm -rf /usr/share/nginx/html/*
RUN rm -rf /etc/nginx/conf.d/*
COPY ./default.conf /etc/nginx/conf.d/
COPY ./build /usr/share/nginx/html/
