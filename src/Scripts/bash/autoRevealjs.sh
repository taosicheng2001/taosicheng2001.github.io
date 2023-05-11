#!/bin/bash

read -p  "Convert current markdown into html (y/n)" decision

if [[ $decision = "yes" || $decision = "y" ]];

then
    revealjs.sh $1
fi

