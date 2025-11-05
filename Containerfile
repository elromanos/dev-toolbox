FROM registry.fedoraproject.org/fedora:43

# Set build-time arguments with default values
ARG NAME=dev-toolbox
ARG VENDOR="elromanos"
ARG VERSION=43

# Set environment variables, falling back to ARGs for default values
ENV NAME=${NAME} \
    VENDOR=${VENDOR} \
    VERSION=${VERSION}

LABEL com.github.containers.toolbox="true" \
      org.opencontainers.image.name="$NAME" \
      org.opencontainers.image.description="My custom Toolbox image." \
      org.opencontainers.image.source="https://github.com/elromanos/dev-toolbox" \
      org.opencontainers.image.version="$VERSION" \
      org.opencontainers.image.vendor="$VENDOR" \
      org.opencontainers.image.documentation="https://github.com/elromanos/dev-toolbox/blob/main/README.md" \
      summary="Image for creating my dev toolbx, from a Fedora container." \
      vendor="$VENDOR" \
      name="$NAME" \
      version="$VERSION"

# Copy required files
COPY files/dnf.conf /etc/dnf/dnf.conf

# Setup the VS Code YUM repository
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
COPY files/vscode.repo /etc/yum.repos.d/

# Install required packages
#
#         bind-utils - for basic DNS troubleshooting
#               code - VS Code
#          diffutils - diff tools
#             direnv - for managing dev environment variables
#               make - for running make tasks
#             man-db - access to man pages
#               pass - managing passwords
#           pinentry - passing passphrases to GPG
#             poetry - managing Python projects
#         pre-commit - running pre-commit tasks
#              pwgen - generating passwords
#                rcm - managing dotfiles
#              rsync - remote copy tool
#               tmux - managing screen sessions
#
RUN dnf install -y bind-utils code diffutils direnv make man-db pass pinentry poetry pre-commit pwgen \
                   rcm tmux && \
    dnf clean all
