Although we're using only one server (for simplicity's sake) in this example….

Let's create a directroy to store our new root signing keys.

```sh
mkdir -p /etc/pki/ssh
```{{execute}}

The keys in this directory are extremely sensitive, so ensure this directory is only readable by the `root` user:

```sh
chmod -R 700 /etc/pki/ssh
```{{execute}}

Once we have a sensible place to store our root signing keys, we need to create them. To do this, we turn to `ssh-keygen(1)` as normal. This is because the only meaningful distinction between a regular SSH keypair and a signing keypair is the way we use the keys we generate. The keys we generate are not fundamentally different than any other keypair.

We'll create an `ed25519` keypair for this example. The default is to create an RSA keypair (using the `-t rsa` option). We'll save the pair of key files in our `/etc/pki/ssh` directory, and we'll give the keyfiles a comment (`-C`) to describe their purpose in natural language.

When you execute the `ssh-keygen` command, you'll be asked for a password to protect your keys. It's critical that this password be a strong one, because in a production environment these keys would be extraordinarily sensitive and valuable.

```sh
ssh-keygen -t ed25519 -f /etc/pki/ssh/ssh_host_signing_key_ed25519 -C 'SSH CA Root Signing Key'
```{{execute}}
