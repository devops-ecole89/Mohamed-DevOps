# Utiliser une image Python légère
FROM python:3.10-slim

# Installer les dépendances système nécessaires
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libssl-dev \
    libffi-dev \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Définir le répertoire de travail
WORKDIR /home/python/app

# Cloner le dépôt Git
RUN git clone -b develop https://github.com/devops-ecole89/Mohamed-DevOps.git

# Définir le répertoire de travail à l'intérieur du dépôt cloné
WORKDIR /home/python/app/Mohamed-DevOps

# Installer les dépendances Python
RUN pip install --no-cache-dir -r requirements.txt

# Définir la variable d'environnement PYTHONPATH pour inclure le répertoire du code
ENV PYTHONPATH=/home/python/app/Mohamed-DevOps

# Exposer le port (si nécessaire)
EXPOSE 5000

# Commande pour exécuter les tests avec pytest
CMD ["pytest"]