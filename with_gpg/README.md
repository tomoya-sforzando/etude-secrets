# How to handle secret files on GitHub

## with GPG as it is

![with GPG as it is](https://user-images.githubusercontent.com/40506652/99053235-41afb880-25dc-11eb-874b-86679cd93992.png)

### Requirements

GPG

### Setup GPG

`brew install gnupg`

#### Encrypt secret files

- Encrypt secret file
  - `gpg --symmetric --cipher-algo AES256 secret.txt`
- Add secret files to `.gitignore`

#### Decrypt secret files

- Decrypt secret file
  - `gpg --decrypt secret.txt.gpg >| secret.txt`

### Setup Git Hooks

First, set passphrase to environment variables.
`export GPG_SECRET_PASSPHRASE=*****`

#### pre-commit to encrypt secret files

```Shell
#!/bin/sh

echo "Running Git Hooks: pre-commit"

secret_txt=/Users/tomoya.kashimada/Workspace/github.com/tomoya-sforzando/etude-secrets/with_gpg/secret.txt
secret_txt_gpg=/Users/tomoya.kashimada/Workspace/github.com/tomoya-sforzando/etude-secrets/with_gpg/secret.txt.gpg

if !(type gpg >/dev/null 2>&1); then
  echo "Error: gpg is not installed." 1>&2
  exit 1
fi

gpg --symmetric --batch --yes --cipher-algo AES256 --passphrase $GPG_SECRET_PASSPHRASE $secret_txt

git add $secret_txt_gpg
git status

exit 0
```

#### post-merge to decrypt secret files

```Shell
#!/bin/sh

echo "Running Git Hooks: post-merge"

secret_txt=/Users/tomoya.kashimada/Workspace/github.com/tomoya-sforzando/etude-secrets/with_gpg/secret.txt
secret_txt_gpg=/Users/tomoya.kashimada/Workspace/github.com/tomoya-sforzando/etude-secrets/with_gpg/secret.txt.gpg

if !(type gpg >/dev/null 2>&1); then
  echo "Error: gpg is not installed." 1>&2
  exit 1
fi

gpg --decrypt --batch --yes --passphrase $GPG_SECRET_PASSPHRASE $secret_txt_gpg >| $secret.txt

exit 0
```

### Setup CI

1. Set passphrase to environment value as `GPG_SECRET_PASSPHRASE` on CI
   - e.g. GitHub > Settings > Secrets
1. Run script on CI as follows

```Shell
#!/bin/sh

secret_txt=with_gpg/secret.txt
secret_txt_gpg=with_gpg/secret.txt.gpg

gpg --quiet --batch --yes --decrypt --passphrase="$GPG_SECRET_PASSPHRASE" \
--output $secret_txt $secret_txt_gpg
```

### References

[Encrypted secrets - GitHub Docs](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets#limits-for-secrets)
