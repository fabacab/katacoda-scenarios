# Overview

This workshop (ultimately intended to be part of a more complete series) walks you through the process of creating a simple, OpenSSH-based Public Key Infrastructure (PKI) for the purpose of authenticating SSH servers to connecting clients.

## Benefits of SSH Certificates

As a system administrator (server-side), using SSH certificates for host authentication enables you to more easily rotate SSH host keys on some periodic schedule without triggering SSH host key verification failures in clients. Certificate-based authentication is also at the heart of solutions such as SSH support in [Cloudflare Access](https://blog.cloudflare.com/public-keys-are-not-enough-for-ssh-security/), so what you learn here will help you in understanding and setting up those systems in your networks.

As an SSH user (client-side), using SSH certificates for host authentication means you no longer have to remember the individual fingerprints of the SSH host keys that servers present to you when you connect to them. Instead, on each connection attempt, your SSH client refers to a single public key contained in a certificate issued by your organization's own Certificate Authority (CA) and checks to see whether the host key of the server you are connecting to was signed (approved) by that authority. This means manually managing entries in your `known_hosts` file for each host you connect to becomes a thing of the past, as does the initial "Are you sure you want to continue connecting (yes/no)?" question when you connect to a new SSH server for the first time.

## Workshop limitations

Not (currently) included in this workshop is:

* the converse, i.e., user authentication with SSH certificates.
* [certificate authentication with SSH products such as Tectia® Server](https://www.ssh.com/manuals/server-admin/64/serverauth-cert.html).

## Prerequisites

To complete this exercise, you should have:

* a basic understanding of asymmetric (public-key) cryptography, and
* a working knowledge of basic OpenSSH server administration when run on a GNU/Linux Operating System.

Let's get started.
