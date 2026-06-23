# Tautulli IP Enforcer - Plugin Unraid

Plugin Unraid pour gérer les IPs bannies et les limites de streams utilisateurs pour Tautulli/Plex.

## 📋 Description

Ce plugin permet de gérer dynamiquement les paramètres du script Tautulli IP Enforcer sans avoir à modifier les fichiers manuellement via un éditeur de texte.

**Fonctionnalités :**
- 🚫 Gestion des IPs bannies (ajout/suppression)
- 👥 Limites de streams par utilisateur (ajout/modification/suppression)
- 📋 Visualisation des logs d'enforcement
- ⚙️ Configuration de l'emplacement et des paramètres Tautulli
- 🔧 Installation et gestion du service systemd

## ⚠️ Prérequis

- **Unraid 6.x ou 7.x**
- **Tautulli** installé (via Docker ou native)
- Accès SSH pour certaines fonctionnalités avancées

## 📥 Installation

### Méthode 1 : Via le plugin (recommandé)

1. Placez le fichier `tautulli-ip-enforcer.plg` sur votre serveur Unraid (dans `/boot/config/plugins/`)
2. Ou utilisez une URL vers le fichier `.plg` hébergé sur GitHub :
   ```
   https://raw.githubusercontent.com/jeremiejt38/Tautulli_IP_Enforcer_UnraidPlugin/main/tautulli-ip-enforcer.plg
   ```

3. Allez dans **Paramètres → Plugins** dans Unraid
4. Cliquez sur **Install** à côté du plugin

### Méthode 2 : Installation manuelle

1. Clonez ce dépôt sur votre serveur :
   ```bash
   git clone https://github.com/jeremiejt38/Tautulli_IP_Enforcer_UnraidPlugin.git
   ```

2. Copiez les fichiers dans le dossier plugins :
   ```bash
   cp -r Tautulli_IP_Enforcer_UnraidPlugin/* /boot/config/plugins/tautulli-ip-enforcer/
   chmod +x /boot/config/plugins/tautulli-ip-enforcer/*.page
   chmod +x /boot/config/plugins/tautulli-ip-enforcer/*.php
   ```

3. Rafraîchissez la page Unraid

## 🚀 Configuration Initiale

Au premier lancement, le plugin affiche un assistant d'installation :

1. **Vérifiez l'emplacement** du script (défaut : `/mnt/user/appdata/tautulli/Tautulli_IP_Enforcer/`)
2. **Entrez l'adresse IP** de votre instance Tautulli
3. **Entrez le port** de Tautulli (défaut : `8181`)
4. **Entrez votre clé API** Tautulli

Cliquez sur **Installer** pour :
- Cloner automatiquement le dépôt GitHub du script
- Créer les fichiers de configuration nécessaires
- Sauvegarder vos paramètres

## 📖 Utilisation

### Onglet IPs Bannies

Ajoutez les adresses IP à bannir. Une IP bannie verra toutes ses sessions Plex terminées.

**Formats supportés :**
- IPv4 (ex: `192.168.1.100`)
- IPv6 (ex: `2001:0db8:85a3:0000:0000:8a2e:0370:7334`)

### Onglet Limites Utilisateurs

Définissez le nombre maximum d'IPs uniques autorisées par utilisateur Plex.

**Exemple :**
- `Jean;1` → Jean peut utiliser 1 seule IP unique
- `Marie;2` → Marie peut utiliser 2 IPs uniques différentes
- `Pierre;5` → Pierre peut utiliser jusqu'à 5 IPs uniques

### Onglet Logs

Visualisez l'historique des actions d'enforcement en temps réel.

### Onglet Paramètres

Modifiez l'emplacement des fichiers, les coordonnées Tautulli, et les messages affichés aux utilisateurs.

### Onglet Service

Gérez le service systemd :
- ▶️ **Démarrer** : Lance le service manuellement
- ⏹️ **Arrêter** : Arrête le service
- 🔄 **Redémarrer** : Redémarre le service
- ⚙️ **Installer le service** : Installe le service systemd (à faire une fois)

## 🔧 Service Systemd

Le script tourne en continu via un service systemd. Pour l'activer au démarrage :

```bash
sudo systemctl enable tautulliipenforcer.service
```

## 📁 Structure des fichiers

```
/mnt/user/appdata/tautulli/Tautulli_IP_Enforcer/
├── tautulliIpEnforcer.py      # Script principal
├── tautulliIpEnforcer.sh      # Script de boucle
├── tautulliipenforcer.service # Service systemd
├── TautulliApiHandler.py      # Module API
├── banned_ips.txt            # IPs bannies (géré via plugin)
├── concurrent_ip_limit.txt   # Limites utilisateurs (géré via plugin)
└── enforce_log.txt          # Logs d'enforcement
```

## 🔨 Dépannage

### Le service ne démarre pas

1. Vérifiez les logs :
   ```bash
   sudo systemctl status tautulliipenforcer.service
   ```

2. Vérifiez que Tautulli est accessible à l'adresse IP configurée

### Le plugin ne trouve pas les fichiers

- Vérifiez que le chemin dans les paramètres est correct
- Vérifiez que les fichiers ont été clonés depuis GitHub

### Erreur de permission

Certaines actions (installation du service) nécessitent des droits sudo. Connectez-vous en SSH :

```bash
sudo nano /etc/sudoers
# Ou exécutez les commandes manuellement avec sudo
```

## 📝 License

- Plugin : [GPL-3.0](./LICENSE)
- Script original : [GPL-3.0](https://github.com/Dosk3n/Tautulli_IP_Enforcer/blob/master/LICENSE)

## 🙏 Remerciements

- Script original créé par [Dosk3n](https://github.com/Dosk3n/Tautulli_IP_Enforcer)
- Inspiré par les plugins Unraid de [Squidly271](https://github.com/Squidly271)
