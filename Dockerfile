FROM vaultwarden/server:latest

ENV I_REALLY_WANT_VOLATILE_STORAGE=false

EXPOSE 80

CMD ["./start.sh"]
