#!/bin/bash

# Ensure privileges
if [ "$EUID" -ne 0 ]; then
  exec sudo "$0" "$@"
fi