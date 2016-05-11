FROM ubuntu:xenial

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

RUN apt-get update -y

RUN apt-get install -y \
	git \
	zsh \
	vim \
	tmux \
	ack-grep \
	curl \
	ruby \
	python2.7

RUN apt-get -y autoremove && \
	apt-get -y clean

ENV HOME /home
WORKDIR /home

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh
RUN git clone git://github.com/nmahoney/dotfiles.git .dotfiles

RUN ln -s $HOME/.dotfiles/.gitconfig $HOME && \
    ln -s $HOME/.dotfiles/.gitignore $HOME && \
    ln -s $HOME/.dotfiles/.tmux.conf $HOME && \
    ln -s $HOME/.dotfiles/.vimrc $HOME && \
    ln -s $HOME/.dotfiles/.zshrc $HOME && \
    ln -s $HOME/.dotfiles/.pryrc $HOME && \
    ln -s $HOME/.dotfiles/.rspec $HOME && \
    ln -s $HOME/.dotfiles/.ackrc $HOME

RUN mkdir ~/.vim ~/.vim/bundle ~/.vim/autoload
RUN chmod +x .dotfiles/bin/install_plugins.sh
RUN .dotfiles/bin/install_plugins.sh

VOLUME ["/dev"]
WORKDIR /dev

ENTRYPOINT ["/usr/bin/zsh"]
CMD ["--login"]
