<p align="center">
    <img src="https://avatars.githubusercontent.com/u/82603435?v=4" width="140px" alt="Helm LOGO"/>
    <br>
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&pause=1000&vCenter=true&width=435&lines=Simple+Debian+Repository;Share+.deb+easily+on+your+hosts" alt="Typing SVG" />
</p>

![Nombre de visites](https://visitor-badge.deta.dev/badge?page_id=qjoly.debianrepo)


# Simple Debian Repository

Ce projet permet de créer facilement un dépôt Debian sous forme d'image Docker en utilisant [aptly](https://www.aptly.info/).

La page d'accueil du dépôt vient du projet [dev-landing-page](https://github.com/flexdinesh/dev-landing-page).


## Getting Started

Ce projet va créer des fichiers `.deb` à partir du dossier `src`. Celui-ci va gérer plusieurs dépôts (`stable` et `unstable` par défaut), les sources du dépôt `stable` se trouvent dans le dossier `src/stable`.

Ainsi, si je veux créer le programme `hello-world` à la version 1.0.0, pour n'importe quelle architecture et à la révision 1 dans le dépôt `stable`, je vais alors créer le dossier `src/stable/hello-world/hello-world_1.0.0-1_all` et une fois packagé dans un `.deb`, il sera à cet emplacement `repo-list/stable/hello-world_1.0.0-1_all.deb`. 

*Pour comprendre comment créer un fichier `.deb`, je vous invite à lire [cette page](https://thebidouilleur.xyz/docs/Adminsys/creer-deb)*

Il est également possible d'importer des `.deb` en plaçant ceux-ci dans le dossier `repo-list` *(suivi du dépôt dans lequel ils seront placés comme `stable` ou `unstable`).* 

Il n'est pas requis que la structure du programme soit déjà créée dans votre volume, vous pouvez très bien utiliser un dossier vide comme volume : le programme va créer seul la structure en ajoutant 2 programmes de test : `hello-world` et `goodbye-world`.

<a href="https://asciinema.org/a/N9JL3ih6jwoLJX4r58Y51NHlf" target="_blank"><img src="https://asciinema.org/a/N9JL3ih6jwoLJX4r58Y51NHlf.svg" /></a>

La page web index.html affiche les instructions pour ajouter le dépôt à votre système. L'URL du dépôt est recupérée depuis la variable d'environnement `WEB_URL`

Exemple: 
![Landing Page](https://github.com/QJoly/DebianRepository/blob/main/.github/web-pages.png?raw=true)

Vous pouvez changer le nom du dépôt en modifiant la variable d'environnement `REPO_NAME`, "TheBidouilleur" par défaut.

Pour personnaliser les liens de la page d'accueil, il suffit de modifier le fichier `html/index.html`.

## Ajouter le dépôt

La racine du site affiche les instructions pour ajouter le dépôt à votre système. Il vous d'avoir `tee`et `wget`.

Démonstration: 

<a href="https://asciinema.org/a/a5ecxeDZjrK7X5uvnSmnFhv6W" target="_blank"><img src="https://asciinema.org/a/a5ecxeDZjrK7X5uvnSmnFhv6W.svg" /></a>

## Source

Le code HTML est créé par le travail de [Flexdinesh](https://github.com/flexdinesh/dev-landing-page).
