#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status

printPurple "✅ Updating package lists..."
sudo apt update || { printPurple "❌ Failed to update package lists"; exit 1; }

printPurple "🔧 Installing required packages: ca-certificates, curl, gnupg, lsb-release..."
sudo apt install -y ca-certificates curl gnupg lsb-release || { printPurple "❌ Failed to install required packages"; exit 1; }

printPurple "🔑 Adding Docker's official GPG key..."
sudo mkdir -p /etc/apt/keyrings || { printPurple "❌ Failed to create keyrings directory"; exit 1; }
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || { printPurple "❌ Failed to add Docker's GPG key"; exit 1; }
sudo chmod a+r /etc/apt/keyrings/docker.gpg || { printPurple "❌ Failed to set permissions for Docker's GPG key"; exit 1; }

printPurple "📦 Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || { printPurple "❌ Failed to set up Docker repository"; exit 1; }

printPurple "✅ Updating package lists after adding Docker repository..."
sudo apt update || { printPurple "❌ Failed to update package lists after adding Docker repository"; exit 1; }

printPurple "🐳 Installing Docker Engine, Docker CLI, containerd, and Docker Compose plugin..."
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin || { printPurple "❌ Failed to install Docker components"; exit 1; }

printPurple "🐳 Verifying Docker installation..."
docker --version || { printPurple "❌ Docker installation verification failed"; exit 1; }

printPurple "🐳 Verifying Docker Compose installation..."
docker-compose --version || { printPurple "❌ Docker Compose installation verification failed"; exit 1; }

printPurple "🔄 Adding the original user to the Docker group..."
sudo usermod -aG docker "${SUDO_USER:-$USER}" || { printPurple "❌ Failed to add user to Docker group"; exit 1; }

printPurple "🎉 Docker and Docker Compose have been successfully installed!"

printPurple "ℹ️ To apply the Docker group changes, please log out and log back in."
