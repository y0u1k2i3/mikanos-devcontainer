# See here for image contents: https://github.com/sarisia/mikanos-docker
ARG VARIANT=latest
# FROM ghcr.io/sarisia/mikanos:${VARIANT}
FROM ghcr.io/sarisia/mikanos:vnc

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-here>

COPY build_boot_loader.sh /home/vscode/edk2/build_boot_loader.sh
RUN chmod +x /home/vscode/edk2/build_boot_loader.sh
