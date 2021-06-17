FROM centos:7.6.1810

COPY test-requirements.txt requirements.txt /tmp/
WORKDIR /tmp

#-----------------------
# install basic packages
#-----------------------
RUN yum -y install \
    fakeroot \ 
    rpm-build \
    python3-devel \
    python3-setuptools \
    libcurl-devel \
    libattr-devel \
 && yum -y groupinstall 'Development Tools'\
 && pip3 install -r requirements.txt \
 && pip3 install -r test-requirements.txt \
 && rm -rf /tmp/*requirements.txt \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && mkdir -p /opt/neutron /opt/kaloom

COPY entrypoint.sh /opt/kaloom/
CMD ["/bin/bash", "/opt/kaloom/entrypoint.sh"]
