#!/bin/bash

set -e

if [ -f "/pgp/key.pgp" ]; then
    echo "pgp key file found."    
    gpg -v --batch --import /pgp/key.pgp

elif [[ ! -z "${SETT_PGP_KEY}" ]]; then
  echo "SETT_PGP_KEY found."
  
  if [[ -z "${SETT_PGP_KEY_PWD}" ]]; then
    echo "ERROR: environment variable SETT_PGP_KEY_PWD not found." 
    exit 1 
  else
    echo "SETT_PGP_KEY_PWD found."
    touch /pgp/key.pw
    printf "%s" "$SETT_PGP_KEY_PWD" > "/pgp/key.pw"
  fi

  gpg -v --batch --import <(echo "$SETT_PGP_KEY")  

else
  echo "ERROR: no file or environment variable with th pgp key found" 
  exit 1 
fi

if [ ! -f "/pgp/key.pw" ]; then
  echo "ERROR: key password not found in /pgp/key.pw" 
  exit 1 
fi

sett "$@"
