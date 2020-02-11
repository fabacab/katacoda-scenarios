# Scaling SSH Authentication with PKI Certificates

This workshop (ultimately intended to be part of a more complete series) walks you through the process of creating a simple, OpenSSH-based Public Key Infrastructure (PKI) for the purpose of authenticating SSH servers to connecting clients.

As a system administrator (server-side), using SSH certificates for host authentication enables you to more easily rotate SSH host keys on some periodic schedule without triggering SSH host key verification failures in clients. Certificate-based authentication is also at the heart of solutions such as SSH support in [Cloudflare Access](https://blog.cloudflare.com/public-keys-are-not-enough-for-ssh-security/), so what you learn here will help you in understanding and setting up those systems in your networks.

As an SSH user (client-side), using SSH certificates for host authentication means you no longer have to remember the individual fingerprints of the SSH host keys servers present to you when you connect to them. Instead, on each connection attempt, your SSH client refers to a single certificate issued by your organization's own Certificate Authority (CA) to determine if the server's SSH host key is valid. Manually managing entries in your `known_hosts` file become a thing of the past.

Not (currently) included in this workshop is:

* the converse, i.e., user authentication with SSH certificates.
* [certificate authentication with SSH products such as Tectia® Server](https://www.ssh.com/manuals/server-admin/64/serverauth-cert.html).

To complete this exercise, you should also have:

* a basic understanding of asymmetric (public-key) cryptography, and
* a working knowledge of basic OpenSSH server administration when run on a GNU/Linux Operating System.

Let's get started.
