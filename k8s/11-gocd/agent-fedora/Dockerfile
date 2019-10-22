FROM gocd/gocd-agent-fedora-30:v19.9.0

USER root

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
RUN yum install clang llvm-devel libxml2-devel libuuid-devel openssl-devel bash patch libstdc++-static make
RUN yum -y clean all

# OSXCross
# Build osxcross with sdk
# Copy target
RUN mkdir -p /opt/osxcross/target
COPY target /opt/osxcross/target

RUN yum -y install scons git bzip2 xz java-openjdk yasm
RUN git clone https://github.com/emscripten-core/emsdk /opt/emsdk
RUN /opt/emsdk/emsdk install latest
# Get the emsdk env variables via /opt/emsdk/emsdk_env.sh 
# or /opt/emsdk/emsdk activate latest
USER root
# Mono glue
RUN yum install -y scons xorg-x11-server-Xvfb pkgconfig libX11-devel libXcursor-devel libXrandr-devel libXinerama-devel libXi-devel mesa-libGL-devel alsa-lib-devel pulseaudio-libs-devel freetype-devel openssl-devel libudev-devel mesa-libGLU-devel mesa-dri-drivers
# Android
RUN yum -y install scons java-1.8.0-openjdk-devel ncurses-compat-libs unzip which gcc gcc-c++ && \
    curl -LO https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip sdk-tools-linux-4333796.zip -d /opt/android && \
    rm sdk-tools-linux-4333796.zip && \
    yes | /opt/android/tools/bin/sdkmanager --licenses && \
    /opt/android/tools/bin/sdkmanager ndk-bundle 'platforms;android-23' 'build-tools;19.1.0' 'build-tools;28.0.3' 'platforms;android-28' 
# ENV ANDROID_HOME=/opt/android
# ENV ANDROID_NDK_ROOT=/opt/android/ndk-bundle/
RUN chown -R go /opt/android
RUN yum install -y mono-complete nuget
RUN yum clean all
RUN rm -rf /var/cache/yum
USER go
