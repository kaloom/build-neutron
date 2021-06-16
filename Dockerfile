FROM centos:7.6.1810

COPY get-pip.py test-requirements.txt requirements.txt /tmp/
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
    mariadb-server \
 && yum -y groupinstall 'Development Tools'\
 && python get-pip.py \
 && pip install setuptools \
 && pip install -r requirements.txt \
 && pip install -r test-requirements.txt \
 && rm -rf /tmp/*requirements.txt \
 && yum clean all \
 && rm -rf /var/cache/yum \
 && mkdir -p /opt/neutron /opt/kaloom

COPY entrypoint.sh /opt/kaloom/
CMD ["/bin/bash", "/opt/kaloom/entrypoint.sh"]
