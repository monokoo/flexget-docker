# Base on minimal debian

FROM bitnami/minideb:jessie  
RUN install_packages python python-pip

# Install deluge
# RUN install_packages deluge
RUN pip install deluge-client

 
# Install flexget
RUN pip install --upgrade setuptools \
    && pip install -I flexget
    
# Cleanup

# Folders and configs
RUN mkdir -p /config \
    && mkdir -p /storage

VOLUME ["/config", "/storage"]

RUN touch /config/config.yml


# Remove config locks
RUN touch /config/.config-lock && rm /config/.config-lock

# Run commands
CMD ["/usr/local/bin/flexget","-c","/config/config.yml", "--loglevel", "info", "daemon", "start"]
