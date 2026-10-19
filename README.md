# Archives Dépêche

Instance indépendante de l’application d’archives, préparée pour la société **Dépêche**. La structure des tables reste identique à l’application d’origine ; cette copie se connecte à la base `archives_depeche`, utilise la charte bleue et le logo fourni de SARL La Dépêche Services.

Cette version affiche uniquement le nom des boîtes (le code reste interne pour préserver la base), utilise le nom de la boîte dans les emplacements, corrige l’affichage des accents dans les noms de fichiers, et limite la recherche rapide aux dossiers, fichiers, boîtes et salles. La recherche avancée conserve ses filtres.

## Test sur ton ordinateur (`localhost`)

Il faut Node.js 18+ et MySQL/MariaDB accessibles depuis l’ordinateur. La base `archives_depeche` doit exister.

```bash
cd archives-depeche
npm ci
cp .env.example .env
# Modifier .env : DB_HOST, DB_USER, DB_PASSWORD, DB_NAME=archives_depeche,
# PORT=3001 et un JWT_SECRET personnel
npm start
```

Ouvre ensuite `http://localhost:3001`. Pour une base déjà remplie, ne lance pas l’initialiseur (voir l’avertissement ci-dessous).

## Configuration locale / serveur

1. Copier `.env.example` vers `.env`.
2. Renseigner les identifiants MySQL correspondant à la base déjà créée `archives_depeche`, ainsi qu’une clé `JWT_SECRET` longue et unique.
3. Garder un port distinct de l’instance OPA (exemple : `PORT=3001`).
4. Installer les dépendances et lancer l’application :

```bash
npm ci
npm start
```

L’application écoute sur le port indiqué dans `.env`.

### Base déjà créée

Cette copie vise la base existante `archives_depeche`. **Ne lancez pas `npm run init-db` si elle contient déjà des données** : le schéma exécute des `DROP TABLE` et recrée les tables. Cette commande est uniquement réservée à une base vide/de test.

Si vous devez initialiser une base vide, vérifiez d’abord les comptes et données d’amorçage présents dans `sql/seed.sql`, puis lancez `npm run init-db`.

## Déploiement côte à côte sur le même serveur (VPS Linux + PM2 + Nginx)

La version OPA reste dans son dossier et conserve son propre port, sa base et ses uploads. Déployer cette copie dans un autre dossier, par exemple `/var/www/archives-depeche`.

```bash
cd /var/www/archives-depeche
cp .env.example .env
nano .env                 # renseigner DB_PASSWORD et JWT_SECRET
npm ci
node server/app.js        # test ; arrêter avec Ctrl+C après vérification
```

Pour le lancement persistant, utilisez PM2 depuis le dossier du projet :

```bash
npm install -g pm2        # seulement si PM2 n’est pas déjà installé
pm2 start server/app.js --name archives-depeche
pm2 save
pm2 startup               # exécuter ensuite la commande système affichée par PM2
```

Associer ensuite un sous-domaine dédié (ex. `archives-depeche.votre-domaine.dz`) à un bloc Nginx qui relaie vers `127.0.0.1:3001` :

```nginx
server {
    listen 80;
    server_name archives-depeche.votre-domaine.dz;

    location / {
        proxy_pass http://127.0.0.1:3001;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
```

Puis tester et recharger Nginx (`sudo nginx -t && sudo systemctl reload nginx`) et activer HTTPS avec Certbot si disponible. Les fichiers téléversés sont dans le dossier propre à cette copie (`public/uploads/`) : sauvegardez-le séparément de celui d’OPA.

## Points à vérifier

- `.env` utilise `DB_NAME=archives_depeche` et le compte MySQL a les droits sur cette base.
- Le port 3001 n’est pas déjà utilisé.
- Les pièces jointes et sauvegardes de Dépêche restent séparées des fichiers d’OPA.
- Consultez les logs en cas de souci : `pm2 logs archives-depeche`.
