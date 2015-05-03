FROM vikraman/gentoo

# Setting up the env to support crossdev.
RUN mkdir -p /usr/local/portage-crossdev/profiles
RUN mkdir -p /usr/local/portage
RUN echo local-crossdev > /usr/local/portage-crossdev/profiles/repo_name
RUN echo 'PORTDIR_OVERLAY="/usr/local/portage-crossdev /usr/local/portage"' >> /etc/portage/make.conf

# Installing and seting up crossdev for i686-elf.
RUN emerge --sync > /dev/null
RUN emerge crossdev
RUN crossdev --stage1 --binutils 2.24-r3 --gcc 4.8.4 --target i686-elf

# User stuff.
VOLUME ["/build"]
WORKDIR /build
RUN useradd -m build
RUN chown -R build:build /build
USER build
