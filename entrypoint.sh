#!/bin/bash

set -e

if [ -f "/pgp/key.pgp" ]; then
    echo "pgp key file found."    
    gpg -v --batch --import /pgp/key.pgp

elif [[ ! -z "${PGP_KEY}" ]]; then
  echo "PGP_KEY found."
  
  if [[ -z "${PGP_KEY_PWD}" ]]; then
    echo "ERROR: environment variable PGP_KEY_PWD not found." 
    exit 1 
  else
    echo "PGP_KEY_PWD found."
    touch /pgp/key.pw
    printf "%s" "$PGP_KEY_PWD" > "/pgp/key.pw"
  fi

  gpg -v --batch --import <(echo "$PGP_KEY")  

else
  echo "ERROR: no file or environment variable with th pgp key found" 
  exit 1 
fi

if [ ! -f "/pgp/key.pw" ]; then
  echo "ERROR: key password not found in /pgp/key.pw" 
  exit 1 
fi

sett "$@"
