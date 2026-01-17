FROM httpd:alpine AS base


RUN sed -i \
    -e 's/^#\(LoadModule proxy_module\)/\1/' \
    -e 's/^#\(LoadModule proxy_http_module\)/\1/' \
    -e 's/^#\(LoadModule proxy_connect_module\)/\1/' \
    -e 's/^#\(LoadModule slotmem_shm_module\)/\1/' \
    /usr/local/apache2/conf/httpd.conf

FROM base AS development
COPY ./virtual-hosts/httpd-proxy-dev.conf /usr/local/apache2/conf/extra/httpd-proxy-dev.conf
RUN echo "Include conf/extra/httpd-proxy-dev.conf" >> /usr/local/apache2/conf/httpd.conf


COPY ./healthcheck.sh /usr/local/apache2/healthcheck.sh
RUN chmod +x /usr/local/apache2/healthcheck.sh

EXPOSE 80


FROM base AS production

COPY ./virtual-hosts/httpd-proxy.conf /usr/local/apache2/conf/extra/proxy-logic.conf
RUN echo "Include conf/extra/proxy-logic.conf" >> /usr/local/apache2/conf/httpd.conf

EXPOSE 80
CMD ["httpd-foreground"]