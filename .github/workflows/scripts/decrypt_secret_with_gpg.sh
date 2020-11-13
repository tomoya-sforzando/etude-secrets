#!/bin/sh

secret_txt=$HOME/with_gpg/secret.txt
secret_txt_gpg=$HOME/with_gpg/secret.txt.gpg

gpg --quiet --batch --yes --decrypt --passphrase="$GPG_SECRET_PASSPHRASE" \
--output $secret_txt $secret_txt_gpg