# Pull base image
FROM kipp/rpi-bpd-rubysrc:v2
MAINTAINER Kipp Bowen <kipp.bowen@axiosengineering.com>

# pull digitalfoosball repo from github
RUN cd /data/repos && git clone https://github.com/jkb-axios/digitalfoosball.git jkb-digitalfoosball
#RUN cd /data/repos/jkb-digitalfoosball && git checkout latest-configuration

# TODO - configure for digitalfoosball

# Define working directory
WORKDIR /data/repos/jkb-digitalfoosball

# Define default command
CMD ["bash"]
