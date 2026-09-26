#!/usr/bin/env bash
set -e -u

PROFILEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${PROFILEDIR}"

sudo rm -rf work/ out/

sed "s|@PROFILEDIR@|${PROFILEDIR}|g" "${PROFILEDIR}/pacman.conf.in" > "${PROFILEDIR}/pacman.conf"

sudo mkarchiso -v -w work -o out .