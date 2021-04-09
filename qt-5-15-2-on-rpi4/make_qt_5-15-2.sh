echo "download qt sources"
wget http://download.qt.io/official_releases/qt/5.15/5.15.2/single/qt-everywhere-src-5.15.2.tar.xz
echo "unpack qt"
tar xf qt-everywhere-src-5.15.2.tar.xz
echo "download qt configurator"
git clone https://github.com/oniongarlic/qt-raspberrypi-configuration.git
cd qt-raspberrypi-configuration && make install DESTDIR=../qt-everywhere-src-5.15.2

echo "install all additional libs for qt 5.15.2"
sudo apt-get update && sudo apt-get upgrade  
sudo apt-get install -y bluez libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev libgstreamer-plugins-bad1.0-dev pulseaudio
sudo apt-get install -y libx11-dev libxscransaver libxscrnsaver libsystemd-dev libb2-dev libharfbuzz-dev libts-dev libxcb* libpthread*
sudo apt-get install -y libxml2-dev libxslt1-dev libminizip-dev libjsoncpp-dev liblcms2-dev libevent-dev libprotobuf-dev protobuf-compiler
sudo apt-get install -y libatspi-dev libgbm-dev gypsy libgypsy libglib2.0-* libbluetooth* libdbuskit-dev libopus-dev libvpx-dev
sudo apt-get install -y libre2-* libicu-* libwebp-dev libwebpdemux2 libwebpmux3 libopus-* libffmpegthumbnailer* libvpx* libsnappy* libglib-* 
sudo apt-get install -y libglib3.0-cil* libglib2* libzlib zlib* glib* snappy ffmpeg opus icu re2 ninja gstreamer gstreamer-* gstreamer1.0* libresourceqt5
sudo apt-get install -y gconf-2.0 gconf2 gperf libasound2-dev libcap-dev libgconf2-dev libgcrypt11 libgcrypt11-dev  libgnome-keyring-dev 
sudo apt-get install -y libnss3-dev libpci-dev libpulse-dev libudev-dev python-gtk2-dev libx11-xcb-dev libatspi2.0-* libsctp* libgles2*
sudo apt-get install -y libc++-dev  libdbus* libfontconfig1* libdrm-common libdrm-dev libxcursor* libxcomposite*  libxi6 libfontconfig1-dev flex
sudo apt-get install -y libxrandr* libxtst* libcap2 libcap2-bin libkhr Bison libbison libbison-dev libgpref gpref nodejs libxfixes-dev
sudo apt-get install -y git gcc g++ cmake libgl1-mesa-dev build-essential  libsqlite3-dev libssl-dev libpng-dev  libglib2.0-dev libraspberrypi-dev
sudo apt-get install -y libfontconfig1 libdbus  libdbus-1-3 libfreetype6 libicu-dev ibinput10 libinput-dev libinput-tools  qtcreator
sudo apt-get install -y libxkbcommon0  libxkbcommon-doc libxkbcommon-x11-0 libxkbcommon-x11-dev libsqlite3-* libsqliteodbc libsqlite-tcl
sudo apt-get install -y libssl* libssl-* libpng-* libjpeg-dev libglib2.0-* libraspberrypi* ninja libsystemd libb2 libproxy-dev libproxy-tools directfb libdirectfb-dev 
sudo apt-get install -y wayland-kms wayland-protocols libclang* libgtk libgtk-3-* liblttng-* libdouble-conversion-dev libfreetype6-dev
sudo apt-get install -y bluez* libbluetooth-dev libasound2* pulseaudio* libpulse-* libpq-dev libpqxx* libmariadbclient-dev libxrender-dev libxkbcommon-dev
sudo apt-get install -y libcups2* libwayland-* libx11-dev libxext-dev libxi-dev libxcomposite-dev latomic gcc-5* g++-5 xbps-src libatomic-devel libdbus-1-dev
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade 
sudo apt autoremove 
echo "start build configuration"
mkdir build-qt-5-15-2
cd build-qt-5-15-2
PKG_CONFIG_LIBDIR=/usr/lib/arm-linux-gnueabihf/pkgconfig:/usr/share/pkgconfig 
../qt-everywhere-src-5.15.2/configure -platform linux-rpi4-v3d-g++ -v -opengl es2 -eglfs -no-gtk -opensource -confirm-license -release -reduce-exports -force-pkg-config -nomake examples -no-compile-examples -skip qtwayland -no-feature-geoservices_mapboxgl -qt-pcre -no-pch -ssl -evdev -system-freetype -fontconfig -glib -prefix /opt/Qt/5.15.2 -qpa qglfs
echo "-platform linux-rpi4-v3d-g++ -march=armv8-a -mtune=cortex-a72 -mfpu=crypto-neon-fp-armv8"

sudo chmod 777 . -R
sed -i '355 a #if defined(__ARM_ARCH_8A__)' /home/pi/qt-everywhere-src-5.15.2/qtscript/src/3rdparty/javascriptcore/JavaScriptCore/wtf/Platform.h
sed -i '356 a #define WTF_ARM_ARCH_VERSION 8' /home/pi/qt-everywhere-src-5.15.2/qtscript/src/3rdparty/javascriptcore/JavaScriptCore/wtf/Platform.h
sed -i '357 a #endif' /home/pi/qt-everywhere-src-5.15.2/qtscript/src/3rdparty/javascriptcore/JavaScriptCore/wtf/Platform.h


echo "start build qt" 
sudo make -j4 NINJAJOBS=-j4
sudo make -j4 NINJAJOBS=-j1
sudo make -j1 NINJAJOBS=-j1

echo "install qt"
sudo make install



