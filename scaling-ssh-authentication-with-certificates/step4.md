Now that both the SSH server and client are correctly configured to use SSH host certificates, you can simply make a connection to the SSH server as usual.

To ensure that we are using the host certificate rather than the plain host key, though, let's first remove any pre-existing knowledge of the appropriate server's host key fingerprints from our SSH known hosts database:

```sh
ssh-keygen -R host01
```{{execute}}

Now we are ready to make a connection to the SSH server that will be authenticated with the server's host certificate:

```sh
ssh host01
```{{execute}}
