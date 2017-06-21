FROM kalilinux/kali-linux-docker:latest
LABEL maintainer "ripples <w@q2zy.com>"

# sources
ADD sources.list /etc/apt/sources.list
ADD pip.conf /root/.pip/pip.conf

RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get -y upgrade && apt-get install -y \
        autojump \
        binutils-arm-linux-gnueabi \
        build-essential \
        debian-keyring \
        g++ \
        gcc \
        gdb-multiarch \
        git \
        httpie \
        libc6-i386 \
        libc6-dev-i386 \
        libevent-dev \
        libffi-dev \
        libgmp-dev \
        libncurses5:i386 \
        libssh-dev \
        libstdc++6:i386 \
        locales \
        ltrace \
        make \
        man \
        nasm \
        nmap \
        openssh-server \
        p7zip-full \
        python \
        python-dev \
        python-pip \
        rsync \
        software-properties-common \
        strace \
        sudo \
        tmux \
        trash-cli \
        wget \
        vim \
        zsh \
    && rm -rf /var/lib/apt/lists/*

# qira
RUN cd ~ && git clone --depth 1 https://github.com/BinaryAnalysisPlatform/qira.git \
    && cd qira/ && yes | ./install.sh

# z3
RUN cd ~ && git clone --depth 1 --branch=z3-4.5.0 https://github.com/Z3Prover/z3.git \
    && cd z3 && python scripts/mk_make.py \
    && cd build && make && make install

RUN pip install -U pip ipython==5.* pwntools

# gdb
RUN git clone --depth 1 https://github.com/longld/peda.git ~/peda \
    && git clone --depth 1 https://github.com/scwuaptx/Pwngdb.git ~/Pwngdb \
    && cp ~/Pwngdb/.gdbinit ~/

# fix locale
RUN locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8

# personal configuration
RUN cd ~ && git clone --depth 1 https://github.com/ripples-alive/CTF-Scripts.git ctf-scripts
ENV PYTHONPATH /root/ctf-scripts/utils
RUN cd ~ && git clone --depth 1 https://github.com/ripples-alive/dotfiles.git .dotfiles \
    && cd .dotfiles && yes | bash bootstrap.sh
RUN TERM=linux TERMINFO=/etc/terminfo \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ripples-alive/oh-my-zsh/master/tools/install.sh)" \
    || chsh -s /bin/zsh
COPY authorized_keys /root/.ssh/authorized_keys
RUN chmod -R 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

# qira port
EXPOSE 3002
EXPOSE 4000
EXPOSE 22

COPY my_init /sbin/
RUN chown root:root /sbin/my_init && chmod 755 /sbin/my_init
ENV WORKDIR /root/workspace
WORKDIR $WORKDIR
CMD ["/bin/zsh"]
