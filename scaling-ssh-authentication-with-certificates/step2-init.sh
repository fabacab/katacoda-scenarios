# Reset user's `known_hosts` database.
ssh-keygen -R host01 && rm -f .ssh/known_hosts.old
