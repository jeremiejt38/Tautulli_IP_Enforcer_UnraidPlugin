# Bin scripts — Tautulli IP Enforcer (Unraid)

Ce répertoire contient des scripts simples pour démarrer/arrêter/redémarrer et vérifier le statut du script Python `tautulliIpEnforcer.py` sur Unraid. Ces scripts ont été ajoutés pour remplacer l'approche systemd (incompatible avec la plupart des installations Unraid) et fournir une gestion par pidfile/log.

Fichiers
- `start.sh` — démarre le script Python en arrière-plan, écrit le PID dans `tautulliipenforcer.pid` et redirige la sortie vers `tautulliipenforcer.log`.
- `stop.sh` — arrête le processus en lisant le PID depuis `tautulliipenforcer.pid` (envoie SIGTERM puis SIGKILL si nécessaire) et supprime le pidfile.
- `restart.sh` — wrapper qui appelle `stop.sh` puis `start.sh`.
- `status.sh` — vérifie si le PID du pidfile correspond à un processus actif et renvoie un code de sortie adapté.

Emplacement attendu
- Plugin dir : `/boot/config/plugins/tautulli-ip-enforcer/`
- pidfile : `/boot/config/plugins/tautulli-ip-enforcer/tautulliipenforcer.pid`
- logfile : `/boot/config/plugins/tautulli-ip-enforcer/tautulliipenforcer.log`
- settings : `/boot/config/plugins/tautulli-ip-enforcer/settings.cfg` (le champ `script_path` est lu pour localiser le script Python)
- Script Python attendu : `<script_path>/tautulliIpEnforcer.py` (par défaut `/mnt/user/appdata/tautulli/Tautulli_IP_Enforcer/tautulliIpEnforcer.py`)

Permissions
Donnez les permissions d'exécution aux scripts :

chmod 755 /boot/config/plugins/tautulli-ip-enforcer/bin/*.sh

Utilisation manuelle
- Démarrer :
  /boot/config/plugins/tautulli-ip-enforcer/bin/start.sh

- Vérifier le statut :
  /boot/config/plugins/tautulli-ip-enforcer/bin/status.sh
  - code de sortie 0 : actif
  - code de sortie 1 : inactif (pas de pidfile)
  - code de sortie 2 : pidfile périmé (pid présent mais processus non trouvé)

- Suivre les logs :
  tail -F /boot/config/plugins/tautulli-ip-enforcer/tautulliipenforcer.log

- Arrêter :
  /boot/config/plugins/tautulli-ip-enforcer/bin/stop.sh

Intégration avec l'UI du plugin
- Le plugin appelle ces scripts pour les actions Démarrer/Arreter/Redemarrer/Status. Assurez-vous que `settings.cfg` contient la clé `script_path` pointant vers le répertoire où réside `tautulliIpEnforcer.py`.

Bonnes pratiques et dépannage
- Assurez-vous que `python3` est installé et accessible depuis le PATH du système.
- Vérifiez que le script Python est exécutable et fonctionne correctement depuis la ligne de commande avant de l'automatiser.
- Si `start.sh` échoue : vérifiez que le chemin vers le script Python est correct et regardez `tautulliipenforcer.log` pour les erreurs.
- Si `status.sh` indique un "Stale pidfile", supprimez manuellement le pidfile si vous êtes sûr que le processus n'existe plus :
  rm -f /boot/config/plugins/tautulli-ip-enforcer/tautulliipenforcer.pid

Sécurité
- Ces scripts sont intentionnellement simples. Ne les exposez pas directement à des interfaces non-trustées.
- Les appels depuis l'UI PHP utilisent `escapeshellarg()` pour éviter les injections ; évitez de modifier les scripts pour exécuter des entrées non filtrées.

Si vous souhaitez que je :
- ajoute des logs plus détaillés (rotation, timestamps),
- modifie `updatePythonScript()` pour générer un fichier `config.ini` utilisable par le script Python,
- ou ajoute une option Docker pour exécuter le script de manière isolée — dites-moi lequel et je prépare la modification.
