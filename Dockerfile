FROM vaultwarden/server:latest

ENV I_REALLY_WANT_VOLATILE_STORAGE=false

ARG VAULTWARDEN_ADMIN_PASSWORD
RUN export ADMIN_TOKEN=$(vaultwarden hash "$VAULTWARDEN_ADMIN_PASSWORD")

EXPOSE 80

CMD ["./start.sh"]
