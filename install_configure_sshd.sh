#!/bin/bash -e

if grep -q 'AuthorizedKeysCommand ' "$SSHD_CONFIG_FILE"; then
  sed -i "s:.*AuthorizedKeysCommand\s.*:AuthorizedKeysCommand ${AUTHORIZED_KEYS_COMMAND_FILE}:g" "$SSHD_CONFIG_FILE"
else
  if ! grep -q "AuthorizedKeysCommand ${AUTHORIZED_KEYS_COMMAND_FILE}" "$SSHD_CONFIG_FILE"; then
    echo "AuthorizedKeysCommand ${AUTHORIZED_KEYS_COMMAND_FILE}" >> "$SSHD_CONFIG_FILE"
  fi
fi

if grep -q 'AuthorizedKeysCommandUser ' "$SSHD_CONFIG_FILE"; then
  sed -i "s:.*AuthorizedKeysCommandUser\s.*:AuthorizedKeysCommandUser nobody:g" "$SSHD_CONFIG_FILE"
else
  if ! grep -q 'AuthorizedKeysCommandUser nobody' "$SSHD_CONFIG_FILE"; then
    echo "AuthorizedKeysCommandUser nobody" >> "$SSHD_CONFIG_FILE"
  fi
fi
