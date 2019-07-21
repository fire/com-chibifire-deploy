FROM gocd/gocd-agent-fedora-29:v19.5.0

# Chibifire.com
RUN yum upgrade -y
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
RUN yum groupinstall -y "Development Libraries"
RUN yum install -y libstdc++-static
RUN yum install -y xar-devel llvm-devel
RUN yum -y clean all
