FROM nextcloud

COPY entrypoint.sh /my-entrypoint.sh
RUN chmod +x /my-entrypoint.sh
ENTRYPOINT ["/my-entrypoint.sh"]
CMD ["apache2-foreground"]
