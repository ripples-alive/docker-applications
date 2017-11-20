FROM kalilinux/kali-linux-docker:latest
LABEL maintainer "ripples <w@q2zy.com>"

# sources
COPY sources.list /etc/apt/sources.list
COPY pip.conf /root/.pip/pip.conf

RUN dpkg --add-architecture i386 \
    && apt-get update && apt-get -y upgrade && apt-get install -y \
        autojump \
        bc \
        binutils-arm-linux-gnueabi \
        build-essential \
        debian-keyring \
        g++ \
        gcc \
        gdb-multiarch \
        git \
        httpie \
        libc6-dbg \
        libc6-i386 \
        libc6-dbg:i386 \
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
        socat \
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

# python libs
RUN pip install -U pip ipython==5.* pwntools virtualenv virtualenvwrapper angr
ENV WORKON_HOME /root/.virtualenvs

# gdb
RUN cd ~ && git clone --depth 1 https://github.com/scwuaptx/Pwngdb.git Pwngdb \
    && git clone --depth 1 https://github.com/pwndbg/pwndbg.git pwndbg \
    && cd pwndbg && ./setup.sh
COPY .gdbinit /root/.gdbinit

# fix locale
RUN locale-gen en_US.UTF-8 && localedef -i en_US -f UTF-8 en_US.UTF-8

# personal configuration
RUN TERM=linux TERMINFO=/etc/terminfo \
    sh -c "$(wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)" \
    || chsh -s /bin/zsh
RUN cd ~ && git clone --recursive --depth 1 https://github.com/ripples-alive/dotfiles.git .dotfiles \
    && yes | .dotfiles/bin/sync-dotfiles || yes | .dotfiles/bin/sync-dotfiles
RUN cd ~ && git clone --depth 1 https://github.com/ripples-alive/CTF-Scripts.git ctf-scripts
ENV PYTHONPATH /root/ctf-scripts/utils
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

COPY extra.zsh /root/.extra
COPY Dockerfile /tmp/Dockerfile
RUN grep '^ENV ' /tmp/Dockerfile | awk '{printf "export %s=%s\n",$2,$3}' \
    | cat - /root/.extra | tee /root/.extra

CMD ["/sbin/my_init"]
