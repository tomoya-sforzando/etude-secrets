# How to handle secret files on GitHub

## with git-secret

### Requirements

- GPG
- [git-secret](https://git-secret.io/)

### Prepare GPG

`brew install gnupg`

```Shell
$ gpg --gen-key
gpg (GnuPG) 2.2.23; Copyright (C) 2020 Free Software Foundation, Inc.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Note: Use "gpg --full-generate-key" for a full featured key generation dialog.

GnuPG needs to construct a user ID to identify your key.

Real name: tomoya-sforzando
Email address: tomoya@sforzando.co.jp
You selected this USER-ID:
    "tomoya-sforzando <tomoya@sforzando.co.jp>"

Change (N)ame, (E)mail, or (O)kay/(Q)uit? O
gpg: key D45E948DE31AD4DB marked as ultimately trusted
gpg: revocation certificate stored as '/Users/tomoya.kashimada/.gnupg/openpgp-revocs.d/8B9905E24BBDE0E61C58155ED45E948DE31AD4DB.rev'
public and secret key created and signed.

pub   rsa3072 2020-11-12 [SC] [expires: 2022-11-12]
      8B9905E24BBDE0E61C58155ED45E948DE31AD4DB
uid                      tomoya-sforzando <tomoya@sforzando.co.jp>
sub   rsa3072 2020-11-12 [E] [expires: 2022-11-12]
```

Export your public-key and share it with members.
`gpg --export tomoya@sforzando.co.jp --armor > public-key_tomoya-sforzando.gpg`

And import member's public-key.
`gpg --import public-key_member.gpg`

### Usage git-secret

`brew install git-secret`

#### (Change `.gitsecret` folder with SECRETS_DIR)

`cd with_git-secret`
`export SECRETS_DIR=with_git-secret/.gitsecret`

#### Initialize the git-secret repository

`git secret init`

#### Add members

```Shell
$ git secret tell tomoya@sforzando.co.jp
gpg: checking the trustdb
gpg: marginals needed: 3  completes needed: 1  trust model: pgp
gpg: depth: 0  valid:   1  signed:   0  trust: 0-, 0q, 0n, 0m, 0f, 1u
gpg: next trustdb check due at 2022-11-12

$ git secret tell member@gpg.email
…
```

#### Add secret files

```Shell
$ git secret add secret.json
git-secret: these files are not in .gitignore: secret.json
git-secret: auto adding them to .gitignore
git-secret: 1 item(s) added.
```

#### Encrypt secret files

```Shell
$ git secret hide
gpg: tomoya@sforzando.co.jp: skipped: public key already present
git-secret: done. 1 of 1 files are hidden.
```

#### Decrypt secret files

```Shell
$ git secret reveal -f
git-secret: done. 1 of 1 files are revealed.
```

`-f` option is…
> forces gpg to overwrite existing files without prompt.

### Setup Git Hooks

#### pre-commit to encrypt secret files

```Shell
#!/bin/sh

echo "Running Git Hooks: pre-commit"

if !(git secret --version >/dev/null 2>&1); then
  echo "Error: git-secret is not installed." 1>&2
  exit 1
fi

git secret hide
git add */.gitsecret/* */*.secret
git status

exit 0
```

#### post-merge to decrypt secret files

```Shell
echo "Running Git Hooks: post-merge"

if !(git secret --version >/dev/null 2>&1); then
  echo "Error: git-secret is not installed." 1>&2
  exit 1
fi

git secret reveal

exit 0
```

### Setup CI

(T.B.D.)
