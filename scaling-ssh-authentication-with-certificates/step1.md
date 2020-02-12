Before you can use an SSH certificate as an SSH server's host key, you must create an SSH keypair with which you will sign your other host keys.

The safety of this "signing keypair" is extremely important because these keys will be used to approve SSH host keys for all the other SSH servers in your infrastructure. In this example, we're only using one SSH server as an example, so we'll be generating and storing the signing keypair on our single server, but in a real-life scenario you would want to generate and store the signing keypair in a far more secure location, such as a secured administrator's workstation.

To actually generate the keypair itself, we turn to `ssh-keygen(1)` as normal. This is because the only meaningful distinction between a regular SSH keypair and a signing keypair is the way we use the keys we generate. The keys we generate for the purpose of signing a server's host keys are not fundamentally different than any other keypair.

**Do this** to create your SSH signing keypair:

1. Create a directroy to store our new signing keys:
    ```sh
    mkdir -p /etc/pki/ssh
    ```{{execute}}
1. As mentioned earlier, the keys in this directory are extremely sensitive, so ensure this directory is only readable by the `root` user:
    ```sh
    chmod -R 700 /etc/pki/ssh
    ```{{execute}}
1. Generate a new, strong SSH keypair for the purpose of signing SSH server host keys. When you execute the `ssh-keygen` command below, you'll be asked for a password to protect your keys. It's critical that this password be a strong one, because in a production environment these keys would be extraordinarily sensitive and valuable.
    ```sh
    ssh-keygen -t ed25519 -f /etc/pki/ssh/ssh_host_signing_key_ed25519 -C 'SSH CA Root Signing Key'
    ```{{execute}}
    The above command creates a keypair whose key type (`-t`) is [`ed25519`](https://en.wikipedia.org/wiki/EdDSA#Ed25519) and whose file contains a comment (`-C`) indicating the purpose of the key ("`SSH CA Root Signing Key`"). The pair of keyfiles constituting the keypair will be created in files (`-f`) in the `/etc/pki/ssh` directory, named `ssh_host_signing_key_ed25519` and `ssh_host_signing_key_ed25519.pub`.

Now that you've generated a signing keypair and protected them on your server's filesystem, we can use them to sign existing or new host keys for SSH servers in your fleet.