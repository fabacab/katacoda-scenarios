#!/bin/bash

grep -q "^@cert-authority host01,localhost,127.0.0.1" ~/.ssh/known_hosts \
    && echo done # Validation successful.
