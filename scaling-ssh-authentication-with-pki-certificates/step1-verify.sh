#!/bin/bash

keyfile=/etc/pki/ssh/ssh_host_signing_key_ed25519
[ -f "$keyfile" ] \
    && [ $(stat -c '%U' "$keyfile") = "root" ] \
        && [ $(stat -c '%a' $(dirname "$keyfile")) -eq 700 ] \
            && echo done
