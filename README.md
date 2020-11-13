# How to handle secret files on GitHub

## 3 ways

1. [Use GPG as it is](https://github.com/tomoya-sforzando/etude-secrets/tree/main/with_gpg)
   - Features
     - Explicitly handle secret files
     - Using only passphrase
   - Pros
     - No need for a private and public key per user
     - We only need is a passphrase
   - Cons
     - Need to keep track of secret files one by one
     - Not sure how best to manage passphrases in local environment
1. [Use git-secret](https://github.com/tomoya-sforzando/etude-secrets/tree/main/with_git-secret)
   - Features
     - Explicitly handle secret files
     - Using Asymmetric Keys
   - Pros
     - Encryption and decryption are explicit and simple commands
       - encrypt: `git secret hide`
       - decrypt: `git secret reveal`
     - Can manage files to be encrypted and decrypted
       - `git secret add <secret-file>`
       - `git secret remove <secret-file>`
     - Can manage users to be decrypted
       - `git secret tell <user@mail.address>`
       - `git secret killperson <user@mail.address>`
   - Cons
     - Need to create private key
     - Need to set users with public key
     - Need to create a private key for CI
1. [Use git-crypt](https://github.com/tomoya-sforzando/etude-secrets/tree/main/with_git-crypt)
   - Features
     - Implicitly handle secret files
     - Using symmetric Key or asymmetric Keys
   - Pros
     - Simplest to handle
     - We only need to share a symmetric key
       - It has ways to use asymmetric keys too
     - Can manage files to be encrypted and decrypted with `.gitattribute`
   - Cons
     - Encrypted and secret files have the same file name
       - Difficult to detect accidents due to misconfiguration
