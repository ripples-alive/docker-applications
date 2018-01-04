FROM xujinkai/aria2-with-webui

RUN apk update && apk add --no-cache su-exec

COPY aria2.conf /conf-copy/aria2.conf
RUN echo -e "\nbt-tracker=$(wget -q -O- https://raw.githubusercontent.com/ngosang/trackerslist/master/trackers_best.txt | sed '/^$/d' | paste -d, -s)" >> /conf-copy/aria2.conf

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/conf-copy/start.sh"]
