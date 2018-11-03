# Copyright 2017 ThoughtWorks, Inc.
# Copyright 2018 K. S. Ernest (iFire) Lee
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM gocd/gocd-agent-centos-7:v18.9.0
MAINTAINER GoCD <go-cd-dev@googlegroups.com>

# Chibifire.com
RUN yum upgrade -y
RUN yum install -y epel-release
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.rpm.sh | bash
RUN yum install -y git-lfs
RUN git lfs install
RUN yum install -y yasm
RUN yum install -y wine
RUN yum install -y mono-devel
RUN yum install -y cmake
RUN yum install -y scons
RUN yum install -y clang
RUN yum install -y glibc-devel.i686 libgcc.i686 libstdc++.i686
RUN yum install -y mingw64-gcc-c++ mingw32-gcc mingw32-gcc-c++
RUN yum install -y python3-pip
RUN pip3 install -U setuptools
RUN pip3 install -U wheel
RUN pip3 install scons
RUN yum install -y mingw64-winpthreads mingw32-winpthreads
RUN yum install -y mingw64-winpthreads-static mingw32-winpthreads-static
RUN yum install -y mingw64-filesystem mingw32-filesystem
RUN yum group install -y "Development Tools"
RUN yum install -y libX11-devel libXcursor-devel libXrandr-devel libXinerama-devel \
    libXi-devel mesa-libGL-devel alsa-lib-devel pulseaudio-libs-devel freetype-devel openssl-devel \
    libudev-devel mesa-libGLU-devel libpng-devel
RUN yum install -y xorg-x11-server-Xvfb
RUN yum install -y which
RUN dnf group install -y "Java Development"
RUN yum install -y mingw32-filesystem
RUN yum install -y bash
RUN alternatives --set ld /usr/bin/ld.gold
RUN yum -y clean all
# End Chibifire.com