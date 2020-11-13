# How to handle secret files on GitHub

## 3 ways

1. [Use GPG as it is](https://github.com/tomoya-sforzando/etude-secrets/tree/main/with_gpg)
   - Pros
     - No need for a private and public key per user
     - All you need is a passphrase
   - Cons
     - Need to keep track of secret files one by one
     - Not sure how best to manage passphrases in local environment
1. [Use git-secret](https://github.com/tomoya-sforzando/etude-secrets/tree/main/with_git-secret)
   - Pros
     - Encryption and decryption are simple commands
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
1. Use git-crypt
