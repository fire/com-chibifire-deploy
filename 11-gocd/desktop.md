```bash
# Chibifire.com
yum upgrade -y
yum install -y git-lfs
git lfs install
yum install -y yasm
yum install -y wine
yum install -y mono-devel
yum install -y cmake
yum install -y scons
yum install -y clang
yum install -y glibc-devel.i686 libgcc.i686 libstdc++.i686
yum install -y mingw64-gcc-c++ mingw32-gcc mingw32-gcc-c++
yum install -y python3-pip
pip3 install -U setuptools
pip3 install -U wheel
pip3 install scons
yum install -y mingw64-winpthreads mingw32-winpthreads
yum install -y mingw64-winpthreads-static mingw32-winpthreads-static
yum install -y mingw64-filesystem mingw32-filesystem
yum group install -y "Development Tools"
yum install -y libX11-devel libXcursor-devel libXrandr-devel libXinerama-devel \
    libXi-devel mesa-libGL-devel alsa-lib-devel pulseaudio-libs-devel freetype-devel openssl-devel \
    libudev-devel mesa-libGLU-devel libpng-devel
yum install -y xorg-x11-server-Xvfb
yum install -y which
dnf group install -y "Java Development"
yum install -y mingw32-filesystem
yum install -y bash
alternatives --set ld /usr/bin/ld.gold
yum groupinstall -y "Development Libraries"
yum install -y libstdc++-static
yum install -y xar-devel llvm-devel
yum install clang llvm-devel libxml2-devel libuuid-devel openssl-devel bash patch libstdc++-static make -y

yum -y install scons git bzip2 xz java-openjdk yasm
git clone https://github.com/emscripten-core/emsdk /opt/emsdk
/opt/emsdk/emsdk install latest

# Mono glue
yum install -y scons xorg-x11-server-Xvfb pkgconfig libX11-devel libXcursor-devel libXrandr-devel libXinerama-devel libXi-devel mesa-libGL-devel alsa-lib-devel pulseaudio-libs-devel freetype-devel openssl-devel libudev-devel mesa-libGLU-devel mesa-dri-drivers
# Android
yum -y install scons java-1.8.0-openjdk-devel ncurses-compat-libs unzip which gcc gcc-c++ && \
    curl -LO https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip sdk-tools-linux-4333796.zip -d /opt/android && \
    rm sdk-tools-linux-4333796.zip && \
    yes | /opt/android/tools/bin/sdkmanager --licenses && \
    /opt/android/tools/bin/sdkmanager ndk-bundle 'platforms;android-23' 'build-tools;19.1.0' 'build-tools;28.0.3' 'platforms;android-28' 

# OSXCross
# Build osxcross with sdk
# mkdir -p /opt/osxcross/target
# cp target /opt/osxcross/target

curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo
yum install -y go-server

mkdir -p /var/go/
chown -R go:go /var/go
sudo su - go
cd ~/
ssh-keygen -t rsa -b 4096 -C "cicd-builder-02@example.com" -f gocd-server-ssh -P ''
ssh-keyscan example.com > gocd_known_hosts
mkdir -p ~/.ssh
cp gocd-server-ssh ~/.ssh/id_rsa
cp gocd-server-ssh.pub ~/.ssh/id_rsa.pub
cp gocd_known_hosts ~/.ssh/known_hosts
rm gocd_known_hosts gocd-server-ssh.pub gocd-server-ssh
chown -R go:go ~/.ssh/
chmod 700 ~/.ssh/
chmod 600 ~/.ssh/*
exit

curl https://download.gocd.org/gocd.repo -o /etc/yum.repos.d/gocd.repo
yum install -y go-agent
systemctl start go-agent

curl -L https://github.com/gocd-contrib/gitlab-oauth-authorization-plugin/releases/download/v2.0.1-52-exp/gitlab-oauth-authorization-plugin-2.0.1-52.jar /var/lib/go-server/plugins/external/gitlab-oauth-authorization-plugin-2.0.1-52.jar

systemctl start go-server
```


