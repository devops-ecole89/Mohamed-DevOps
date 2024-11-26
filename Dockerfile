# Utiliser une image Ubuntu officielle comme base
FROM ubuntu:20.04

# Prévenir les invites interactives pour tzdata et autres paquets
ENV DEBIAN_FRONTEND=noninteractive

# Mettre à jour le système et installer les dépendances
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    nginx \
    python3 \
    python3-venv \
    python3-pip \
    emacs-nox \
    curl \
    git \
    ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Ajouter un utilisateur non-root pour plus de sécurité (optionnel)
RUN useradd -ms /bin/bash appuser

# Configurer Nginx
COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port 80 pour Nginx
EXPOSE 80

# Lancer Nginx en premier plan
CMD ["nginx", "-g", "daemon off;"]
