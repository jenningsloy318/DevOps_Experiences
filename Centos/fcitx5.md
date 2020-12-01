
Build fcitx5 on centos 8
---
- if need qt4 integration, please also install qt-devel (4.8.7)
- install cldr-emoji-annotation
    ```
    dnf install -y  "cmake" "desktop-file-utils" "extra-cmake-modules" "gcc-c++" "systemd-rpm-macros" "pkgconfig(cairo)" "pkgconfig(cldr-emoji-annotation)" "pkgconfig(dri)" "pkgconfig(enchant)" "pkgconfig(expat)" "pkgconfig(fmt)" "pkgconfig(gdk-pixbuf-2.0)" "pkgconfig(iso-codes)" "pkgconfig(json-c)" "pkgconfig(pango)" "pkgconfig(uuid)" "pkgconfig(libsystemd)" "pkgconfig(wayland-egl)" "pkgconfig(wayland-client)" "pkgconfig(wayland-protocols)" "pkgconfig(xcb)" "pkgconfig(xkbcommon-x11)" "pkgconfig(xkbfile)" "pkgconfig(xcb-ewmh)" "pkgconfig(xcb-imdkit)" "pkgconfig(xcb-icccm)" "pkgconfig(xcb-keysyms)" "pkgconfig(xkeyboard-config)" 
    rpmbuild -ba  cldr-emoji-annotation.spec
    rpm -ivh /root/rpmbuild/RPMS/noarch/cldr-emoji-annotation-38~beta-3.el8.noarch.rpm   /root/rpmbuild/RPMS/noarch/cldr-emoji-annotation-dtd-38~beta-3.el8.noarch.rpm /root/rpmbuild/RPMS/noarch/cldr-emoji-annotation-devel-38~beta-3.el8.noarch.rpm
    ```

- install xcb-imdkit
    ```
    dnf install -y "cmake" "extra-cmake-modules" "gcc-c++" "pkgconfig(xcb)" "pkgconfig(xcb-keysyms)" "pkgconfig(xcb-util)"
    rpmbuild -ba xcb-imdkit.spec
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/xcb-imdkit-1.0.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/xcb-imdkit-devel-1.0.0-1.el8.x86_64.rpm
    ```
    

- install fcitx5
    ```
    dnf install -y "cmake" "desktop-file-utils" "extra-cmake-modules" "gcc-c++" "systemd-rpm-macros" "pkgconfig(cairo)" "pkgconfig(cldr-emoji-annotation)" "pkgconfig(dri)" "pkgconfig(enchant)" "pkgconfig(expat)" "pkgconfig(fmt)" "pkgconfig(gdk-pixbuf-2.0)" "pkgconfig(iso-codes)" "pkgconfig(json-c)" "pkgconfig(pango)" "pkgconfig(uuid)" "pkgconfig(libsystemd)" "pkgconfig(wayland-egl)" "pkgconfig(wayland-client)" "pkgconfig(wayland-protocols)" "pkgconfig(xcb)" "pkgconfig(xkbcommon-x11)" "pkgconfig(xkbfile)" "pkgconfig(xcb-ewmh)" "pkgconfig(xcb-imdkit)" "pkgconfig(xcb-icccm)" "pkgconfig(xcb-keysyms)" "pkgconfig(xkeyboard-config)" "pkgconfig(appstream-glib)"
    rpmbuld -ba fcitx5.spec 
    dnf install -y /root/rpmbuild/RPMS/x86_64/fcitx5-5.0.1-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/fcitx5-data-5.0.1-2.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/fcitx5-devel-5.0.1-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/fcitx5-autostart-5.0.1-2.el8.noarch.rpm
    ```

- install  fcitx5-lua
    ```
    dnf install  -y  pkgconfig(lua)

    rpmbuild -ba fcitx5-lua.spec
    rpm -ivh /root/rpmbuild/RPMS/x86_64/fcitx5-lua-5.0.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/fcitx5-lua-devel-5.0.0-1.el8.x86_64.rpm
    ```
- install fcitx5-qt 
    ```
    dnf install  -y "gnupg2" "cmake" "extra-cmake-modules" "gcc-c++" "ninja-build" "pkgconfig(xkbcommon-x11)" "pkgconfig(Fcitx5Utils)" "pkgconfig(Qt5)" "pkgconfig(Qt5Core)" "pkgconfig(Qt5Gui)" "gettext" "qt5-qtbase-private-devel"
    rpmbuild -ba fcitx5-qt.spec
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/fcitx5-qt-5.0.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/fcitx5-qt-devel-5.0.0-1.el8.x86_64.rpm
    ```
- install opencc 
    ```
    dnf install -y "gcc-c++" "gettext" "cmake" "doxygen" "python3"
    rpmbuild -ba opencc.spec 
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/opencc-1.1.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/opencc-tools-1.1.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/opencc-devel-1.1.1-1.el8.x86_64.rpm
    ```

- install libime
    ```
    dnf install -y "gnupg2" "boost-devel" "cmake" "extra-cmake-modules" "fcitx5-qt-devel" "fcitx5-lua-devel" "gcc-c++"  "ninja-build" "gettext-devel" "pkgconfig(libcurl)" "pkgconfig(fmt)" "pkgconfig(Qt5WebKit)" "pkgconfig(Qt5WebKitWidgets)" "pkgconfig(opencc)" "pkgconfig(Fcitx5Core)" "pkgconfig(Fcitx5Module)"
    rpmuild -ba libime.spec
    rpm -ivh /root/rpmbuild/RPMS/x86_64/libime-1.0.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/libime-data-1.0.1-1.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/libime-devel-1.0.1-1.el8.x86_64.rpm
    ```
- install fcitx5-chinese-addons.spec
    ```
    dnf install -y "gnupg2" "boost-devel" "cmake" "extra-cmake-modules" "fcitx5-qt-devel" "fcitx5-lua-devel" "gcc-c++" "ninja-build" "gettext-devel" "pkgconfig(libcurl)" "pkgconfig(fmt)" "pkgconfig(Qt5WebKit)" "pkgconfig(Qt5WebKitWidgets)" "pkgconfig(opencc)" "pkgconfig(Fcitx5Core)" "pkgconfig(Fcitx5Module)"

    rpmbuild -ba fcitx5-chinese-addons.spec
    rpm -ivh /root/rpmbuild/RPMS/x86_64/fcitx5-chinese-addons-5.0.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/fcitx5-chinese-addons-data-5.0.1-1.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/fcitx5-chinese-addons-devel-5.0.1-1.el8.x86_64.rpm
    ```
- install fcitx5-configtool