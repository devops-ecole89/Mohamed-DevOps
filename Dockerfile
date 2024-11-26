# Utiliser une image Ubuntu officielle comme base
FROM ubuntu:20.04

# Prévenir les invites interactives pour tzdata et autres paquets
ENV DEBIAN_FRONTEND=noninteractive

# Étape 1 : Mettre à jour le système et installer les dépendances
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
    nginx \
    python3 \
    python3-venv \
    python3-pip \
    python3-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-setuptools \
    emacs-nox \
    curl \
    git \
    ca-certificates && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Création d'un groupe et ajout de l'utilisateur www-data à ce groupe
RUN groupadd --system myprojectgroup && usermod -aG myprojectgroup www-data

# Etape 2 : Création d'un environnement virtuel Python
RUN mkdir /myproject
WORKDIR /myproject
RUN python3 -m venv myprojectenv

# Activer l'environnement virtuel
ENV PATH="/myproject/myprojectenv/bin:$PATH"

# Etape 3 : Installation des dépendances et configuration de Flask
RUN pip install --upgrade pip wheel
RUN pip install Flask gunicorn

# Copier les fichiers de l'application Flask
COPY myproject.py /myproject/myproject.py
COPY wsgi.py /myproject/wsgi.py

# Etape 5 : Configuration de Nginx pour les demandes de proxy
COPY nginx.conf /etc/nginx/sites-available/myproject
RUN ln -s /etc/nginx/sites-available/myproject /etc/nginx/sites-enabled
RUN rm /etc/nginx/sites-enabled/default

# Exposer le port 80 pour Nginx
EXPOSE 80

# Copier le script start dans le conteneur
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Utiliser le script comme point d'entrée du conteneur
CMD ["/start.sh"]
