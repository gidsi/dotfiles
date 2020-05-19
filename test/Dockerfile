FROM archlinux:latest

RUN echo "Server = http://mirror.pseudoform.org/$repo/os/$arch" >> /etc/pacman.d/mirrorlist
RUN pacman -Syyu --noconfirm python sudo
