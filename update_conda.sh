#!/bin/bash

# Detect CONDA_DEFAULT_ENV if set and it's "base"
if [[ -z "${CONDA_DEFAULT_ENV}" ]] || [[ "${CONDA_DEFAULT_ENV}" != "base" ]]; then
    echo ""
    echo "!!! Conda enviroment not set to 'base'. Exiting."
    echo ""
    exit 1
fi

conda update --all -y
conda clean --all -y
