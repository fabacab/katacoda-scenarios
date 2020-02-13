certificate_file="/etc/pki/ssh/ssh_host_ed25519_key.pub"
certificate_data="$(mktemp certdata.XXXXX)"

[ ! -f "$certificate_file" ] && exit 1 # Validation failure, missing cert.

# Print certificate data, strip leading whitespace.
ssh-keygen -L -f "$certificate_file" \
    sed -e 's/^\W*//g' > "$certificate_data"

[ 0 -ne $(grep -q '^Type:.*host certificate$' "$certificate_data"; echo $?) ] \
    && exit 1 # Validation failure, incorrect cert type.

[ 0 -ne $(grep -q "HostCertificate $certificate_file" /etc/ssh/sshd_config; echo $?) ] \
    && exit 1 # Validation failure, bad SSH daemon config.

# Audit SSH's running config.
ssh -o "StrictHostKeyChecking=yes" -o "IdentitiesOnly=yes" -v host01 2>&1 \
    | grep -q "Server host certificate:"
[ 0 -ne "$?" ] && exit 1 # Validation failure, running config is missing cert.

rm -f "$certificate_data" # Cleanup temporary files.

echo done # Validation successful.
