#!/bin/bash
set -e
#set -x
cd /data

# function that will build .deb files in specific folder
function build_deb {
    echo "Build .deb files for repo $1"
    cd src/$1
    base_dir=$(pwd)
    # iterate through all folders in src/$1
    for folder in $(ls); do
        echo "Build all .debs for $folder"
        cd $folder
        for version in $(ls); do
            echo "Build $version"
            dpkg-deb --build $version
            mkdir -p ${root_dir}/repo-list/$1/
            mv ${version}.deb ${root_dir}/repo-list/$1/
            cd $base_dir/$folder
        done
        cd $base_dir 
    done
    cd $root_dir
}

function run_nginx {
    list_repo=$(aptly repo list -raw)

    if [ -z "$WEB_URL" ]; then
        WEB_URL="http://URL_OF_THIS_SITE"
    fi

    code_text=$(echo -e "wget -O - -q $WEB_URL/gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/thebidouilleur.gpg<br>")

    for repo in $(aptly repo list -raw); do
        code_text=$(echo -e "$code_text<br>deb $WEB_URL $repo main")
    done

    cp -r /data/html/* /var/www/html/ 
    echo -e "$code_text"

    sed -i -z "s;CODE_HERE;${code_text};" /var/www/html/index.html

    service nginx start
    tail -f /var/log/nginx/access.log
}

# check if repo-list exists
if [ ! -d "repo-list" ]; then
    echo "repo-list does not exists"
fi

root_dir=$(pwd)
repos=$(ls repo-list)

rm -rf ~/.aptly/
mkdir -p ~/.aptly/public/ /data/gpg/

# if GPG_EMAIL is empty, define a default value
if [ -z "$GPG_EMAIL" ]; then
    GPG_EMAIL="aptly@default"
fi

nb_of_key=$(gpg --list-keys | grep "^pub" | wc -l)

echo "$nb_of_key keys are stored in gnugpg"

# if /root/.gnupg does not exist, generate keys or copy from volume
if [ ! -f "/data/gpg/key" ]; then
    echo "Generate GPG key"
    mkdir -p /root/.gnupg
    chmod 700 /root/.gnupg
    gpg --full-gen-key --batch <(echo "Key-Type: 1"; \
                             echo "Key-Length: 4096"; \
                             echo "Subkey-Type: 1"; \
                             echo "Subkey-Length: 4096"; \
                             echo "Expire-Date: 0"; \
                             echo "Name-Real: Root Superuser"; \
                             echo "Name-Email: $GPG_EMAIL"; \
                             echo "%no-protection"; )
    # export gpg key to volume
    gpg --list-keys
    gpg -o /data/gpg/key --export-secret-key 
else
    echo "Copy GPG key from volume"
    gpg  --no-tty --import /data/gpg/key 
    echo "Key imported"
fi

GPG_KEYID=$(gpg --batch --list-keys | grep -oP '[A-Z0-9]{10,}')

# If ~/.aptly/public/gpg does not exists, then create it
if [ ! -f "/root/.aptly/public/gpg" ]; then
    gpg --batch --armor --output ~/.aptly/public/gpg --export $GPG_KEYID
fi

for repo in $repos; do
    if [ -d "src/$repo" ]; then
        echo "Directory src/$repo exists."
        build_deb "$repo"
        aptly repo create $repo
        aptly repo add $repo repo-list/$repo
        aptly snapshot create $repo from repo $repo
        aptly publish snapshot -architectures="amd64,arm64" -distribution="$repo" -gpg-key="$GPG_KEYID" $repo
    else
        echo "Directory src/$repo does not exist."
    fi
done

#aptly serve
rm -rf /var/www/html/*
mv ~/.aptly/public/* /var/www/html

run_nginx
