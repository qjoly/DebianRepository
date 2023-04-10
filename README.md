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

Ainsi, si je veux créer le programme `hello-world` à la version 1.0.0, pour n'importe quelle architecture et ce programme est la révision 1 dans le dépôt `stable`, alors je vais créer le dossier `src/stable/hello-world/hello-world_1.0.0-1_all` et une fois packagé dans un `.deb`, il sera à cet emplacement `repo-list/stable/hello-world_1.0.0-1_all.deb`