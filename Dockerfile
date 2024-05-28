FROM ghcr.io/actions/actions-runner:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN sudo apt clean
RUN sudo apt update -y && \
    sudo apt upgrade -y && \
    sudo apt install -y \
    curl git gcc cmake make build-essential libmagic1 libmagic-dev gnupg zip


RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/yarn.gpg
#RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
#    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN echo "deb [signed-by=/etc/apt/trusted.gpg.d/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
# Update package list and install Yarn
RUN sudo apt update && sudo apt install -y yarn

RUN sudo apt-get remove nodejs npm nodejs-doc -y
RUN sudo apt-get purge nodejs -y
RUN sudo dpkg --remove --force-remove-reinstreq libnode-dev
RUN sudo dpkg --remove --force-remove-reinstreq libnode72:amd64
RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN sudo bash nodesource_setup.sh
RUN sudo apt install nodejs -y

RUN sudo npm install netlify-cli -g
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN sudo ./aws/install
RUN aws --version
RUN node -v
RUN npm -v

# Clean up APT when done
RUN sudo apt clean && sudo rm -rf /var/lib/apt/lists/*

# Verify Yarn installation
RUN yarn --version