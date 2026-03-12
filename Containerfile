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

# Install required packages
#
#         bind-utils - for basic DNS troubleshooting
#          diffutils - diff tools
#             direnv - for managing dev environment variables
#            iputils - network monitoring tools
#               make - for running make tasks
#             man-db - access to man pages
#               pass - managing passwords
#           pinentry - passing passphrases to GPG
#         pre-commit - running pre-commit tasks
#              pwgen - generating passwords
#                rcm - managing dotfiles
#              timew - Time tracking utility
#               tmux - managing screen sessions
#                 uv - managing Python projects
#
RUN dnf install -y bind-utils diffutils direnv iputils make man-db pass pinentry pre-commit pwgen \
                   rcm timew tmux uv && \
    dnf clean all
