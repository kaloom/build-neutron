FROM centos:7.6.1810

COPY test-requirements.txt requirements.txt /tmp/
WORKDIR /tmp

#-----------------------
# install basic packages
#-----------------------
RUN yum -y install \
    git \
    fakeroot \ 
    rpm-build \
    python-devel \
    which \
    mariadb-server\
 && yum -y groupinstall 'Development Tools'\
 && yum clean all \
 && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
 && python get-pip.py \
 && pip install setuptools \
 && pip install -r requirements.txt \
 && pip install -r test-requirements.txt \
 && rm -rf /tmp/*requirements.txt \
 && mkdir -p /opt/neutron /opt/kaloom

COPY entrypoint.sh /opt/kaloom/
CMD ["/bin/bash", "/opt/kaloom/entrypoint.sh"]
