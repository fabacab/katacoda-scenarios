With your signing key at the ready, it's time to sign the host key (or keys) of your SSH server fleet.

If you have many SSH servers for which you need to gather and sign host keys, consider using the `ssh-keyscan(1)` utility included in the [OpenSSH](https://www.openssh.com/) distrubtion. In this workshop, since we are working with only a single server for the sake of simplicity, we already have all the host keys we need in the OpenSSH server's `/etc/ssh` directory.

An *SSH host key* is the SSH identity of the server itself, just as a user's private SSH key is that user's SSH identity and corresponds to the user accounts that they are permitted to log in as. By signing an SSH host key, we create a *SSH certificate file* that contains:

* the *public* SSH host key of the server,
* the name (or names) which identifies the entity to which the certificate belongs (called a *principal* in PKI terminology),
* a unique ID that will be used to identify this principal's public key in your (hypothetical) SSH PKI,
* optionally, numerous attributes such as the time period for which the certificate is valid, and
* a signature created using our private SSH signing key.

Notice that we always sign SSH host *public* keys, never private keys. It's also a good idea to include at least several of the optional attributes, since the default certificates generated will be unrestricted and valid forever. Also note that SSH certificates overlap with but are not in the same format as X.509 certificates used in, for example, the global TLS (and HTTPS) infrastructures.

**Do this** to create the server's SSH certificate:

1. Use `ssh-keygen` again, this time with the `-s` option and the `-h` flag:
    ```sh
    ssh-keygen -s /etc/pki/ssh/ssh_host_signing_key_ed25519 -h -V +1w -n host01 -I example-host /etc/ssh/ssh_host_ed25519_key.pub
    ```
    In the above command the `-s` option specifies the (private) signing key to use, the `-h` flag indicates that the generated certificate should be for an SSH host (rather than an SSH user), the `-V` option specifies a validity time period (using standard SSH time patterns; `1w` is equal to one week), the `-n` option is used to select the principal name, which is hostname to which the SSH will ultimately connect, the `-I` option provides a unique key ID, and the final argument specifies the SSH host public key to sign.

This command will have created a new certificate, `/etc/ssh/ssh_host_ed25519_key-cert.pub`, which the SSH server can now use to assert its identity to connecting clients.

Next, once the server's SSH host key is signed and its certificate file generated, we need to configure the SSH server to use the new certificate file in place of (or in addition to) its existing plain SSH host key.

**Do this** to configure the OpenSSH daemon to use the new host certificate:

1. Add a line like `HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub` to your SSH sever's configuration file.
    ```
    echo "HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub" >> /etc/ssh/sshd_config
    ```{{execute}}
1. Instruct the SSH daemon to reload its configuration file:
    ```sh
    sudo systemctl reload ssh.service
    ```{{execute}}
