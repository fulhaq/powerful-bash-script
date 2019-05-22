#!/usr/bin/env bash
#INFRASTRUCTURE
declare -a arr=("devops" "jenkins-shared-library" "k8-desired-state" "k8-prod-desired-state")
for i in "${arr[@]}"
do
   echo "$i"
    git clone git@bitbucket.org:napagroupnyc/$i.git ~/Documents/napa/infrastructure/$i/
done

#TRIDENT-NAPA
declare -a arr=("trident-front-end" "trident-back-end")
for i in "${arr[@]}"
do
   echo "$i"
    git clone git@bitbucket.org:napagroupnyc/$i.git ~/Documents/napa/trident/$i/
done

#TRIDENT
declare -a arr=("k8-desired-state" "k8-prod-desired-state" "devops")
for i in "${arr[@]}"
do
   echo "$i"
    git clone git@bitbucket.org:tridentx/$i.git ~/Documents/tridentx/devops/$i/
done

