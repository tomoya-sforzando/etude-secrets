# How to handle secret files on GitHub

## with git-crypt

![GitHub Actions](https://user-images.githubusercontent.com/40506652/99068603-28b10280-25f0-11eb-8fd3-454e5e7559d1.png)

Secret files are encrypted under their original names.
![Secret files are encrypted under their original names](https://user-images.githubusercontent.com/40506652/99068671-48e0c180-25f0-11eb-9b10-c41bf2dd6c99.png)

### Requirements

- GPG
- [git-crypt](https://github.com/AGWA/git-crypt)

### Setup GPG

`brew install gnupg`

### Usage git-crypt

`brew install git-crypt`

#### Initialize the git-secret repository

`git-crypt init`

#### Add secret files on `.gitattributes`

```Git Attributes
.gitattributes !filter !diff
secret.txt filter=git-crypt diff=git-crypt
```

#### Export symmetric key

`git-crypt export-key with_git-crypt/symmetric_key`

- Share it with members
- Add `symmetric_key` to `.gitignore`

#### Encrypt secret files

> **Files which you choose to protect are encrypted when committed**, and decrypted when checked out.

#### Decrypt secret files with `symmetric_key`

`git-crypt unlock with_git-crypt/symmetric_key`

### Setup Git Hooks

#### pre-commit to encrypt secret files

Not need.

#### post-merge to decrypt secret files

```Shell
#!/bin/sh

echo "Running Git Hooks: post-merge"

symmetric_key=/Users/tomoya.kashimada/Workspace/github.com/tomoya-sforzando/etude-secrets/with_git-crypt/symmetric_key

if !(type git-crypt >/dev/null 2>&1); then
  echo "Error: git-crypt is not installed." 1>&2
  exit 1
fi

git-crypt unlock $symmetric_key

exit 0
```

### Setup CI

See [sliteteam/github-action-git-crypt-unlock: Github Action to unlock git-crypt secrets](https://github.com/sliteteam/github-action-git-crypt-unlock)
