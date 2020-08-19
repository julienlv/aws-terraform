#!/usr/bin/env bash

apt -y update && apt -y upgrade
touch /tmp/cloud-init-ok
