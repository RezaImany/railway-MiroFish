FROM mirofish-nodefix-test

COPY railway/start.sh /usr/local/bin/railway-start.sh
RUN chmod +x /usr/local/bin/railway-start.sh

CMD ["/usr/local/bin/railway-start.sh"]
