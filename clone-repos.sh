#!/usr/bin/env bash
#INFRASTRUCTURE
declare -a arr=("devops" "jenkins-shared-library" "k8-desired-state" "k8-prod-desired-state")
for i in "${arr[@]}"
do
   echo "$i"
    git clone git@bitbucket.org:napagroupnyc/$i.git ~/Documents/napa/infrastructure/$i/
done

#TRIDENT
declare -a arr=("trident-front-end" "trident-back-end")
for i in "${arr[@]}"
do
   echo "$i"
    git clone git@bitbucket.org:napagroupnyc/$i.git ~/Documents/napa/trident/$i/
done

