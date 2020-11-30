Build QT5 on centos 8
---

- install qt 
    ```
    rpmbuild -ba qt5.spec
    ......
    Wrote: /root/rpmbuild/SRPMS/qt5-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-devel-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-rpm-macros-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-srpm-macros-5.15.1-1.el8.noarch.rpm

    rpm -Uvh   /root/rpmbuild/RPMS/noarch/qt5-rpm-macros-5.15.1-1.el8.noarch.rpm /root/rpmbuild/RPMS/noarch/qt5-srpm-macros-5.15.1-1.el8.noarch.rpm
    ```
- install qt5-qtbase 
    ```
    dnf install mysql-devel "pkgconfig(libproxy-1.0)" "pkgconfig(vulkan)" -y 
    rpmbuild -ba qt5-qtbase.spec

    .....
    Wrote: /root/rpmbuild/SRPMS/qt5-qtbase-5.15.1-5.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtbase-common-5.15.1-5.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-devel-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-private-devel-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-examples-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-static-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-mysql-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-odbc-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-postgresql-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-gui-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-debugsource-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-debuginfo-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-devel-debuginfo-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-examples-debuginfo-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-mysql-debuginfo-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-odbc-debuginfo-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-postgresql-debuginfo-5.15.1-5.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtbase-gui-debuginfo-5.15.1-5.el8.x86_64.rpm

    rpm -Uvh /root/rpmbuild/RPMS/x86_64/qt5-qtbase-5.15.1-5.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/qt5-qtbase-common-5.15.1-5.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtbase-private-devel-5.15.1-5.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtbase-static-5.15.1-5.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtbase-devel-5.15.1-5.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtbase-gui-5.15.1-5.el8.x86_64.rpm
    ```

- install qt5-qtdeclarative
    ```
    rpmbuild -ba qt5-qtdeclarative.spec
     ...
    Wrote: /root/rpmbuild/SRPMS/qt5-qtdeclarative-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-static-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-devel-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtdeclarative-static-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtimageformats
    ```
    rpmbuild -ba qt5-qtimageformats.spec

    Wrote: /root/rpmbuild/SRPMS/qt5-qtimageformats-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtimageformats-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtimageformats-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtimageformats-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtimageformats-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtxmlpatterns
    ```
    rpmbuild -ba qt5-qtxmlpatterns.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtxmlpatterns-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-devel-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-5.15.1-1.el8.x86_64.rpm
    ```

- install libaesgm
    ```
    rpmbuild -ba libaesgm.spec

    Wrote: /root/rpmbuild/SRPMS/libaesgm-20090429-23.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaesgm-20090429-23.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaesgm-devel-20090429-23.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaesgm-debugsource-20090429-23.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaesgm-debuginfo-20090429-23.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/libaesgm-20090429-23.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/libaesgm-devel-20090429-23.el8.x86_64.rpm
    ```

- install irrlicht
    ```
    rpmbuild -ba irrlicht.spec 
    Wrote: /root/rpmbuild/SRPMS/irrlicht-1.8.4-15.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrlicht-1.8.4-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrlicht-devel-1.8.4-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrXML-1.8.4-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrXML-devel-1.8.4-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrlicht-debugsource-1.8.4-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrlicht-debuginfo-1.8.4-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/irrXML-debuginfo-1.8.4-15.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/irrlicht-1.8.4-15.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/irrlicht-devel-1.8.4-15.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/irrXML-1.8.4-15.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/irrXML-devel-1.8.4-15.el8.x86_64.rpm
    ```
- install allegro
    ```
    dnf install libXpm-devel libXxf86dga-devel texinfo -y
    rpmbuild -ba allegro.spec 
    Wrote: /root/rpmbuild/SRPMS/allegro-4.4.3.1-4.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-devel-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-tools-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-jack-plugin-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/alleggl-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/alleggl-devel-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/jpgalleg-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/jpgalleg-devel-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-loadpng-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-loadpng-devel-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-logg-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-logg-devel-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-debugsource-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-devel-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-tools-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-jack-plugin-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/alleggl-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/jpgalleg-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-loadpng-debuginfo-4.4.3.1-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/allegro-logg-debuginfo-4.4.3.1-4.el8.x86_64.rpm

    dnf install -y  /root/rpmbuild/RPMS/x86_64/allegro-4.4.3.1-4.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/allegro-devel-4.4.3.1-4.el8.x86_64.rpm
    ```

- install DevIL
    ```
    dnf install SDL-devel -y
    rpmbuild -ba DevIL.spec
    Wrote: /root/rpmbuild/SRPMS/DevIL-1.7.8-35.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-1.7.8-35.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-devel-1.7.8-35.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-ILUT-1.7.8-35.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-ILUT-devel-1.7.8-35.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-debugsource-1.7.8-35.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-debuginfo-1.7.8-35.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/DevIL-ILUT-debuginfo-1.7.8-35.el8.x86_64.rpm
    
    rpm -ivh /root/rpmbuild/RPMS/x86_64/DevIL-1.7.8-35.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/DevIL-devel-1.7.8-35.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/DevIL-ILUT-1.7.8-35.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/DevIL-ILUT-devel-1.7.8-35.el8.x86_64.rpm
    ```
- install poly2tri
    ```
    rpmbuild -ba poly2tri.spec
    Wrote: /root/rpmbuild/SRPMS/poly2tri-0.0-21.20130501hg26242d0aa7b8.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/poly2tri-0.0-21.20130501hg26242d0aa7b8.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/poly2tri-devel-0.0-21.20130501hg26242d0aa7b8.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/poly2tri-debugsource-0.0-21.20130501hg26242d0aa7b8.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/poly2tri-debuginfo-0.0-21.20130501hg26242d0aa7b8.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/poly2tri-0.0-21.20130501hg26242d0aa7b8.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/poly2tri-devel-0.0-21.20130501hg26242d0aa7b8.el8.x86_64.rpm
    ```

- install assimp
    ```
    dnf install -y gtest-devel minizip-compat-devel "pkgconfig(zzip-zlib-config)" poly2tri-devel
    rpmbuild -ba assimp.spec
    Wrote: /root/rpmbuild/SRPMS/assimp-3.3.1-26.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/assimp-3.3.1-26.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/assimp-devel-3.3.1-26.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/python3-assimp-3.3.1-26.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/assimp-doc-3.3.1-26.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/assimp-debugsource-3.3.1-26.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/assimp-debuginfo-3.3.1-26.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/assimp-3.3.1-26.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/assimp-devel-3.3.1-26.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/python3-assimp-3.3.1-26.el8.noarch.rpm

    ```
- install qt5-qt3d 
    ```
    rpmbuild -ba qt5-qt3d.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qt3d-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qt3d-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qt3d-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qttools
    ```
    dnf install llvm-devel -y
    rpmbuild -ba qt5-qttools.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qttools-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qttools-common-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-static-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-designer-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-designercomponents-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-help-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-assistant-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-designer-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-linguist-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qdbusviewer-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-doctools-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-designer-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-designercomponents-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-help-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-assistant-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-designer-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-linguist-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qdbusviewer-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-doctools-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qttools-examples-debuginfo-5.15.1-1.el8.x86_64.rpm


    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qttools-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/qt5-qttools-common-5.15.1-1.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/qt5-qttools-devel-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qttools-static-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-designer-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-assistant-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-linguist-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-designer-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-designercomponents-5.15.1-1.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/qt5-qdbusviewer-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-doctools-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qttools-libs-help-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtsvg
    ```
    rpmbuild -ba qt5-qtsvg.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtsvg-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtsvg-devel-5.15.1-1.el8.x86_64.rpm

- install qt5ct
    ```
    rpmbuild -ba qt5ct.spec
    Wrote: /root/rpmbuild/SRPMS/qt5ct-1.1-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5ct-1.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5ct-debugsource-1.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5ct-debuginfo-1.1-2.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5ct-1.1-2.el8.x86_64.rpm
    ```

- install qt5-qt3d
    ```
    rpmbuild -ba qt5-qt3d.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qt3d-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qt3d-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qt3d-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qt3d-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtaccountsservice
    ```
    dnf install extra-cmake-modules -y
    rpmbuild -ba qt5-qtaccountsservice.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtaccountsservice-0.6.0-15.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtaccountsservice-0.6.0-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtaccountsservice-devel-0.6.0-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtaccountsservice-debugsource-0.6.0-15.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtaccountsservice-debuginfo-0.6.0-15.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtaccountsservice-0.6.0-15.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtaccountsservice-devel-0.6.0-15.el8.x86_64.rpm
    ```
- install qt5-qtcanvas3d
    ```
    rpmbuild -ba qt5-qtcanvas3d.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtcanvas3d-5.12.5-6.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcanvas3d-5.12.5-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcanvas3d-examples-5.12.5-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcanvas3d-debugsource-5.12.5-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcanvas3d-debuginfo-5.12.5-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcanvas3d-examples-debuginfo-5.12.5-6.el8.x86_64.rpm

    rpm -vih  /root/rpmbuild/RPMS/x86_64/qt5-qtcanvas3d-5.12.5-6.el8.x86_64.rpm 
    ```
- install qt5-qtcharts
    ```
    rpmbuild -ba qt5-qtcharts.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtcharts-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-devel-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtcharts-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtconfiguration
    ```
     rpmbuild -ba qt5-qtconfiguration.spec
     Wrote: /root/rpmbuild/SRPMS/qt5-qtconfiguration-0.3.1-13.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconfiguration-0.3.1-13.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconfiguration-devel-0.3.1-13.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconfiguration-debugsource-0.3.1-13.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconfiguration-debuginfo-0.3.1-13.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtconfiguration-0.3.1-13.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtconfiguration-devel-0.3.1-13.el8.x86_64.rpm
    ```
- install  qt5-qtconnectivity
    ```
    dnf install "pkgconfig(bluez)" -y
    rpmbuild -ba qt5-qtconnectivity.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtconnectivity-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtconnectivity-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtdatavis3d
    ```
    rpmbuild -ba qt5-qtdatavis3d.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtdatavis3d-5.14.2-3.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-5.14.2-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-devel-5.14.2-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-examples-5.14.2-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-debugsource-5.14.2-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-debuginfo-5.14.2-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-examples-debuginfo-5.14.2-3.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-5.14.2-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtdatavis3d-devel-5.14.2-3.el8.x86_64.rpm
    ```
- install qt5-qtenginio
    ```
    rpmbuild -ba qt5-qtenginio.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtenginio-1.6.2-32.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-1.6.2-32.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-devel-1.6.2-32.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtenginio-doc-1.6.2-32.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-examples-1.6.2-32.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-debugsource-1.6.2-32.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-debuginfo-1.6.2-32.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-examples-debuginfo-1.6.2-32.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-1.6.2-32.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtenginio-devel-1.6.2-32.el8.x86_64.rpm
    ```

- install qt5-qtgamepad
    ```
    dnf install -y "pkgconfig(sdl2)"
     rpmbuild -ba qt5-qtgamepad.spec
     Wrote: /root/rpmbuild/SRPMS/qt5-qtgamepad-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtgamepad-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtgraphicaleffects
    ```
    rpmbuild -ba qt5-qtgraphicaleffects.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtgraphicaleffects-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgraphicaleffects-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgraphicaleffects-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtgraphicaleffects-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtgraphicaleffects-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtlocation
    ```
    rpmbuild -ba qt5-qtlocation.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtlocation-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtlocation-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtmultimedia
    ```
    dnf install "pkgconfig(gstreamer-plugins-bad-1.0)" -y
    rpmbuild -ba qt5-qtmultimedia.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtmultimedia-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtmultimedia-devel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtnetworkauth
    ```
    rpmbuild -ba qt5-qtnetworkauth.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtnetworkauth-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtnetworkauth-devel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtpbfimageformat
    ```
    dnf install protobuf-lite-devel -y
    rpmbuild -ba qt5-qtpbfimageformat.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtpbfimageformat-2.2-4.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtpbfimageformat-2.2-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtpbfimageformat-debugsource-2.2-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtpbfimageformat-debuginfo-2.2-4.el8.x86_64.rpm
    
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtpbfimageformat-2.2-4.el8.x86_64.rpm
    ```
- install qt5-qtquickcontrols2
    ```
    rpmbuild -ba qt5-qtquickcontrols2.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtquickcontrols2-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols2-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtquickcontrols
    ```
    rpmbuild -ba qt5-qtquickcontrols.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtquickcontrols-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtquickcontrols-5.15.1-1.el8.x86_64.rpm
    ```


- install qt5-qtremoteobjects
    ```
    rpmbuild -ba qt5-qtremoteobjects.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtremoteobjects-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-examples-debuginfo-5.15.1-1.el8.x86_64.rpm\
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtremoteobjects-devel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtscript
    ```
    dnf install xorg-x11-server-Xvfb  -y
    rpmbuild -ba qt5-qtscript.spec 

    Wrote: /root/rpmbuild/SRPMS/qt5-qtscript-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscript-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscript-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscript-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscript-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscript-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscript-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtscript-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtscript-devel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qttranslations
    ```
    rpmbuild -ba qt5-qttranslations.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qttranslations-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qttranslations-5.15.1-1.el8.noarch.rpm
    rpm -ivh /root/rpmbuild/RPMS/noarch/qt5-qttranslations-5.15.1-1.el8.noarch.rpm
    ```
- install qt5-qtvirtualkeyboard
    ```
    rpmbuild -ba qt5-qtvirtualkeyboard.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtvirtualkeyboard-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtvirtualkeyboard-devel-5.15.1-1.el8.x86_64.rpm
    ```


- install qt5-qtwayland
    ```
     dnf install tree -y
     rpmbuild -ba qt5-qtwayland.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtwayland-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtwayland-devel-5.15.1-1.el8.x86_64.rpm
    ```


- install qt5-qtwebsockets
    ```
    rpmbuild -ba qt5-qtwebsockets.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtwebsockets-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtwebsockets-devel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtwebchannel
    ```
    rpmbuild -ba qt5-qtwebchannel.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtwebchannel-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-examples-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-devel-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtwebchannel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-doc
    ```
    rpmbuild -ba qt5-doc.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-doc-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtbase-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qt3d-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtcharts-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtconnectivity-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtdeclarative-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtgraphicaleffects-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtimageformats-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtmultimedia-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtquickcontrols2-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtquickcontrols-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtscript-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtscxml-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtsensors-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtserialbus-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtserialport-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtsvg-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qttools-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtvirtualkeyboard-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtwebchannel-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtwebsockets-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtx11extras-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtspeech-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtremoteobjects-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtpurchasing-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtwayland-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtwebview-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtlocation-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtxmlpatterns-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtdatavis3d-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtgamepad-doc-5.15.1-1.el8.noarch.rpm

    rpm -ivh /root/rpmbuild/RPMS/noarch/qt5-*-doc-*.rpm
    ```


- install qt5-qtsensors
    ```
    rpmbuild -ba qt5-qtsensors.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtsensors-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtsensors-devel-5.15.1-1.el8.x86_64.rpm
    ```
- install qt5-qtwebengine
    ```
    dnf install -y bison gperf libstdc++-static  "pkgconfig(lcms2)" "pkgconfig(libevent)" "pkgconfig(libpci)" "pkgconfig(opus)" "pkgconfig(xscrnsaver)" python2-rpm-macros snappy-devel  yasm

    rpmbuild -ba qt5-qtwebengine.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtwebengine-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-devtools-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qt5-qtwebengine-doc-5.15.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-devel-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtwebengine-devtools-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/qt5-qtwebengine-doc-5.15.1-1.el8.noarch.rpm
    ```

- install qt5-qtwebkit
```
dnf install -y hyphen-devel "pkgconfig(ruby)" "pngcrush"
rpmbuild -ba qt5-qtwebkit.spec
Wrote: /root/rpmbuild/SRPMS/qt5-qtwebkit-5.212.0-0.52.alpha4.el8.src.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebkit-5.212.0-0.52.alpha4.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebkit-devel-5.212.0-0.52.alpha4.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebkit-debugsource-5.212.0-0.52.alpha4.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebkit-debuginfo-5.212.0-0.52.alpha4.el8.x86_64.rpm
rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtwebkit-5.212.0-0.52.alpha4.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtwebkit-devel-5.212.0-0.52.alpha4.el8.x86_64.rpm
```

- install qt5-qtwebview
    ```
    rpmbuild -ba qt5-qtwebview.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtwebview-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtwebview-5.15.1-1.el8.x86_64.rpm
    ```
- intall qt5-qtx11extras
    ```
    rpmbuild -ba qt5-qtx11extras.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtx11extras-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtx11extras-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtx11extras-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtx11extras-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtx11extras-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtx11extras-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtx11extras-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtxmlpatterns
    ```
    rpmbuild -ba qt5-qtxmlpatterns.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtxmlpatterns-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-devel-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-devel-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtxmlpatterns-5.15.1-1.el8.x86_64.rpm 
    ```



- install qt5-qtscxml
    ```
    rpmbuild -ba qt5-qtscxml.spec 
    Wrote: /root/rpmbuild/SRPMS/qt5-qtscxml-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtscxml-devel-5.15.1-1.el8.x86_64.rpm  
    ```
- install qt5-qtserialport
    ```
    rpmbuild -ba qt5-qtserialport.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtserialport-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-5.15.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/qt5-qtserialport-devel-5.15.1-1.el8.x86_64.rpm  
    ```

- install qt5-qtserialbus
    ```
    rpmbuild -ba qt5-qtserialbus.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtserialbus-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtserialbus-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtspeech
    ```
    dnf install -y speech-dispatcher-devel
    rpmbuild -ba qt5-qtspeech.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtspeech-5.15.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-devel-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-examples-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-speechd-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-debugsource-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-examples-debuginfo-5.15.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-speechd-debuginfo-5.15.1-1.el8.x86_64.rpm

    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-5.15.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qt5-qtspeech-devel-5.15.1-1.el8.x86_64.rpm
    ```

- install qt5-qtstyleplugins
    ```
    rpmbuild -ba qt5-qtstyleplugins.spec
    Wrote: /root/rpmbuild/SRPMS/qt5-qtstyleplugins-5.0.0-42.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtstyleplugins-5.0.0-42.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtstyleplugins-debugsource-5.0.0-42.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qt5-qtstyleplugins-debuginfo-5.0.0-42.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qt5-qtstyleplugins-5.0.0-42.el8.x86_64.rpm
    ```

- install qwt5-qt5
    ```
    rpmbuild -ba qwt5-qt5.spec
    Wrote: /root/rpmbuild/SRPMS/qwt5-qt5-5.2.3a-6.20190819giteeacc44.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwt5-qt5-5.2.3a-6.20190819giteeacc44.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwt5-qt5-devel-5.2.3a-6.20190819giteeacc44.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qwt5-qt5-doc-5.2.3a-6.20190819giteeacc44.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwt5-qt5-debugsource-5.2.3a-6.20190819giteeacc44.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwt5-qt5-debuginfo-5.2.3a-6.20190819giteeacc44.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/qwt5-qt5-5.2.3a-6.20190819giteeacc44.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/qwt5-qt5-devel-5.2.3a-6.20190819giteeacc44.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/qwt5-qt5-doc-5.2.3a-6.20190819giteeacc44.el8.noarch.rpm
    ```

- install qwtplot3d-qt5
    ```
    rpmbuild -ba qwtplot3d-qt5.spec
    Wrote: /root/rpmbuild/SRPMS/qwtplot3d-qt5-0.3.1a-12.20200509git45df8fb.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwtplot3d-qt5-0.3.1a-12.20200509git45df8fb.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwtplot3d-qt5-devel-0.3.1a-12.20200509git45df8fb.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwtplot3d-qt5-debugsource-0.3.1a-12.20200509git45df8fb.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qwtplot3d-qt5-debuginfo-0.3.1a-12.20200509git45df8fb.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/qwtplot3d-qt5-0.3.1a-12.20200509git45df8fb.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/qwtplot3d-qt5-devel-0.3.1a-12.20200509git45df8fb.el8.x86_64.rpm
    ```














- install kf5 
    ```
    rpmbuild -ba kf5.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-filesystem-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kf5-rpm-macros-5.73.0-1.el8.noarch.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-filesystem-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/kf5-rpm-macros-5.73.0-1.el8.noarch.rpm
    ```
- install appstream-data
    ```
    rpmbuild -ba appstream-data.spec
    Wrote: /root/rpmbuild/SRPMS/appstream-data-33-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/appstream-data-33-1.el8.noarch.rpm
    rpm -ivh /root/rpmbuild/RPMS/noarch/appstream-data-33-1.el8.noarch.rpm
    ```
- install appstream
    ```
    dnf install -y libstemmer-devel "pkgconfig(libsoup-2.4)" "pkgconfig(libsoup-2.4)" "pkgconfig(lmdb)" "pkgconfig(packagekit-glib2)" "pkgconfig(yaml-0.1)"
    rpmbuild -ba appstream.spec
    Wrote: /root/rpmbuild/SRPMS/appstream-0.12.11-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-0.12.11-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-devel-0.12.11-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-qt-0.12.11-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-qt-devel-0.12.11-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-debugsource-0.12.11-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-debuginfo-0.12.11-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/appstream-qt-debuginfo-0.12.11-2.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/appstream-0.12.11-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/appstream-devel-0.12.11-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/appstream-qt-0.12.11-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/appstream-qt-devel-0.12.11-2.el8.x86_64.rpm
    ```


- install extra-cmake-modules
    ```
    dnf install python3-sphinx -y
    rpmbuild -ba extra-cmake-modules.spec
    Wrote: /root/rpmbuild/SRPMS/extra-cmake-modules-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/extra-cmake-modules-5.73.0-1.el8.noarch.rpm
    rpm -ivh /root/rpmbuild/SRPMS/extra-cmake-modules-5.73.0-1.el8.noarch.rpm
    ```
- install kf5-kcalendarcore
    ```
    dnf install -y extra-cmake-modules libical-devel
    rpmbuild -ba kf5-kcalendarcore.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcalendarcore-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarcore-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarcore-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarcore-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarcore-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kcalendarcore-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kcalendarcore-devel-5.73.0-1.el8.x86_64.rpm
    ```


- install kf5-kdbusaddons
    ```
    rpmbuild -ba kf5-kdbusaddons.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kdbusaddons-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdbusaddons-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdbusaddons-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdbusaddons-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdbusaddons-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdbusaddons-5.73.0-1.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/kf5-kdbusaddons-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kcodecs
    ```
    rpmbuild -ba kf5-kcodecs.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kcodecs-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcodecs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcodecs-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcodecs-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcodecs-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kcodecs-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kcodecs-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kconfig
    ```
    rpmbuild -ba kf5-kconfig.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kconfig-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-core-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-gui-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kf5-kconfig-doc-5.73.0-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-core-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfig-gui-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kconfig-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kconfig-devel-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kconfig-core-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kconfig-gui-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/kf5-kconfig-doc-5.73.0-1.el8.noarch.rpm
    ```


- install kf5-ki18n
    ```
    rpmbuild -ba kf5-ki18n.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-ki18n-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ki18n-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ki18n-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ki18n-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ki18n-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-ki18n-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-ki18n-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kcoreaddons
    ```
    rpmbuild -ba kf5-kcoreaddons.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcoreaddons-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcoreaddons-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcoreaddons-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcoreaddons-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcoreaddons-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kcoreaddons-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kcoreaddons-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kcontacts
    ```
    rpmbuild -ba kf5-kcontacts.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcontacts-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcontacts-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcontacts-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcontacts-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcontacts-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kcontacts-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kcontacts-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kwidgetsaddons
    ```
    rpmbuild -ba kf5-kwidgetsaddons.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kwidgetsaddons-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwidgetsaddons-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwidgetsaddons-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwidgetsaddons-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwidgetsaddons-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kwidgetsaddons-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kwidgetsaddons-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kmime
    ```
    rpmbuild -ba kf5-kmime.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kmime-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kmime-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kmime-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-kcompletion
    ```
    rpmbuild -ba kf5-kcompletion.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcompletion-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcompletion-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcompletion-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcompletion-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcompletion-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kcompletion-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kcompletion-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-attica
    ```
    rpmbuild -ba kf5-attica.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-attica-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-attica-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-attica-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-attica-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-attica-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-attica-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-attica-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kwindowsystem
    ```
    rpmbuild -ba kf5-kwindowsystem.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kwindowsystem-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwindowsystem-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwindowsystem-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwindowsystem-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwindowsystem-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kwindowsystem-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kwindowsystem-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kcrash
    ```
    rpmbuild -ba kf5-kcrash.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcrash-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcrash-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcrash-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcrash-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcrash-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kcrash-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kcrash-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-bluez-qt
    ```
    rpmbuild -ba kf5-bluez-qt.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-bluez-qt-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-bluez-qt-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-bluez-qt-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-bluez-qt-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-bluez-qt-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-bluez-qt-5.73.0-1.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/kf5-bluez-qt-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-gpgmepp
    ```
    rpmbuild -ba kf5-gpgmepp.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-gpgmepp-16.08.3-14.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-gpgmepp-16.08.3-14.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-gpgmepp-devel-16.08.3-14.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-gpgmepp-debugsource-16.08.3-14.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-gpgmepp-debuginfo-16.08.3-14.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-gpgmepp-16.08.3-14.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-gpgmepp-devel-16.08.3-14.el8.x86_64.rpm
    ```


- install kf5-sonnet
    ```
    dnf install -y hunspell-devel
    rpmbuild -ba kf5-sonnet.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-sonnet-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-core-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-ui-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-core-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-sonnet-ui-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-sonnet-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-sonnet-devel-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-sonnet-core-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-sonnet-ui-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-karchive
    ```
    rpmbuild -ba kf5-karchive.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-karchive-5.73.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-karchive-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-karchive-devel-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-karchive-debugsource-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-karchive-debuginfo-5.73.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-karchive-5.73.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-karchive-devel-5.73.0-2.el8.x86_64.rpm
    ```



- install catdoc
    ```
    dnf install tk -y
    rpmbuild -ba catdoc.spec
    Wrote: /root/rpmbuild/SRPMS/catdoc-0.95-9.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/catdoc-0.95-9.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/catdoc-debugsource-0.95-9.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/catdoc-debuginfo-0.95-9.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/catdoc-0.95-9.el8.x86_64.rpm
    ```
- install ebook-tools
    ```
    dnf install "pkgconfig(libzip)" -y
    rpmbuld -ba ebook-tools.spec
    Wrote: /root/rpmbuild/SRPMS/ebook-tools-0.2.2-19.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/ebook-tools-0.2.2-19.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/ebook-tools-devel-0.2.2-19.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/ebook-tools-libs-0.2.2-19.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/ebook-tools-debugsource-0.2.2-19.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/ebook-tools-debuginfo-0.2.2-19.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/ebook-tools-libs-debuginfo-0.2.2-19.el8.x86_64.rpm 
    rpm -ivh /root/rpmbuild/RPMS/x86_64/ebook-tools-devel-0.2.2-19.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/ebook-tools-libs-0.2.2-19.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/ebook-tools-0.2.2-19.el8.x86_64.rpm
    ```
- install kf5-kfilemetadata
    ```
    dnf install -y "pkgconfig(exiv2)"  libattr-devel
    rpmbuild -ba kf5-kfilemetadata.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kfilemetadata-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kfilemetadata-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kfilemetadata-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kfilemetadata-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kfilemetadata-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kfilemetadata-devel-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kfilemetadata-5.73.0-1.el8.x86_64.rpm
    ```



- install kf5-kidletime
    ```
    rpmbuild -ba kf5-kidletime.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kidletime-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidletime-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidletime-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidletime-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidletime-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kidletime-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kidletime-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-solid
    ```
    dnf install -y libupnp-devel
    rpmbuild -ba kf5-solid.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-solid-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-solid-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-solid-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-solid-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-solid-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-solid-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-solid-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kauth
    ```
    rpmbuild -ba kf5-kauth.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kauth-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kauth-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kauth-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kauth-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kauth-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kauth-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kauth-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kdoctools
    ```
    rpmbuild -ba kf5-kdoctools.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kdoctools-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdoctools-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdoctools-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdoctools-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdoctools-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdoctools-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kdoctools-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kguiaddons
    ```
    rpmbuild -ba kf5-kguiaddons.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kguiaddons-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kguiaddons-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kguiaddons-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kguiaddons-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kguiaddons-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kguiaddons-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kguiaddons-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kconfigwidgets
    ```
    rpmbuild -ba kf5-kconfigwidgets.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kconfigwidgets-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfigwidgets-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfigwidgets-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfigwidgets-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kconfigwidgets-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ihv  /root/rpmbuild/RPMS/x86_64/kf5-kconfigwidgets-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kconfigwidgets-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kitemviews
    ```
    rpmbuild -ba kf5-kitemviews.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kitemviews-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemviews-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemviews-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemviews-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemviews-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kitemviews-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kitemviews-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kiconthemes
    ```
    rpmbuild -ba kf5-kiconthemes.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kiconthemes-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kiconthemes-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kiconthemes-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kiconthemes-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kiconthemes-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kiconthemes-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kiconthemes-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kservice
    ```
    Wrote: /root/rpmbuild/SRPMS/kf5-kservice-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kservice-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kservice-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kservice-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kservice-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kservice-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kservice-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kglobalaccel
    ```
    rpmbuild -ba kf5-kglobalaccel.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kglobalaccel-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-libs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-libs-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-libs-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kglobalaccel-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install ktextwidgets
    ```
    rpmbuild -ba kf5-ktextwidgets.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-ktextwidgets-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktextwidgets-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktextwidgets-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktextwidgets-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktextwidgets-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-ktextwidgets-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-ktextwidgets-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kxmlgui
    ```
    rpmbuild -ba kf5-kxmlgui.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kxmlgui-5.73.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlgui-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlgui-devel-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlgui-debugsource-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlgui-debuginfo-5.73.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kxmlgui-5.73.0-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kxmlgui-devel-5.73.0-2.el8.x86_64.rpm
    ```

- install kf5-kbookmarks
    ```
    rpmbuild -ba kf5-kbookmarks.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kbookmarks-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kbookmarks-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kbookmarks-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kbookmarks-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kbookmarks-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kbookmarks-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kbookmarks-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kjobwidgets
    ```
    rpmbuild -ba kf5-kjobwidgets.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kjobwidgets-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjobwidgets-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjobwidgets-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjobwidgets-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjobwidgets-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kjobwidgets-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kjobwidgets-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install phonon-qt
    ```
    rpmbuild -ba phonon.spec
    Wrote: /root/rpmbuild/SRPMS/phonon-4.11.1-6.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/phonon-qt5-4.11.1-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/phonon-qt5-devel-4.11.1-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/phonon-debugsource-4.11.1-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/phonon-qt5-debuginfo-4.11.1-6.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/phonon-qt5-4.11.1-6.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/phonon-qt5-devel-4.11.1-6.el8.x86_64.rpm
    ```

- install kf5-knotifications
    ```
    rpmbuild -ba kf5-knotifications.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-knotifications-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifications-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifications-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifications-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifications-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-knotifications-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-knotifications-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kwallet
    ```
    rpmbuild -ba kf5-kwallet.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kwallet-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwallet-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwallet-libs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwallet-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwallet-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwallet-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwallet-libs-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kwallet-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kwallet-libs-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kwallet-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kded
```
rpmbuild -ba kf5-kded.spec
Wrote: /root/rpmbuild/SRPMS/kf5-kded-5.73.0-1.el8.src.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kded-5.73.0-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kded-devel-5.73.0-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kded-debugsource-5.73.0-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kded-debuginfo-5.73.0-1.el8.x86_64.rpm

rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kded-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kded-devel-5.73.0-1.el8.x86_64.rpm
```

- install kf5-kio
    ```
    dnf install libacl-devel -y
    rpmbuild -ba kf5-kio.spec

    Wrote: /root/rpmbuild/SRPMS/kf5-kio-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kf5-kio-doc-5.73.0-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-core-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-core-libs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-widgets-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-widgets-libs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-file-widgets-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-gui-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-ntlm-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-devel-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-core-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-core-libs-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-widgets-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-widgets-libs-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-file-widgets-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-gui-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kio-ntlm-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kio-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kio-devel-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/kf5-kio-doc-5.73.0-1.el8.noarch.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kio-core-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kio-core-libs-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kio-widgets-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kio-widgets-libs-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kio-file-widgets-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kio-gui-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kio-ntlm-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kinit
    ```
    rpmbuild -ba kf5-kinit.spec

    Wrote: /root/rpmbuild/SRPMS/kf5-kinit-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kinit-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kinit-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kinit-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kinit-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kinit-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kinit-devel-5.73.0-1.el8.x86_64.rpm
    ```


- install kf5-baloo
    ```
    rpmbuild -ba kf5-baloo.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-baloo-5.73.0-3.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-devel-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-file-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-libs-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-debugsource-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-debuginfo-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-file-debuginfo-5.73.0-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-baloo-libs-debuginfo-5.73.0-3.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-baloo-5.73.0-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-baloo-devel-5.73.0-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-baloo-file-5.73.0-3.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-baloo-libs-5.73.0-3.el8.x86_64.rpm
    ```

- install kf5-kemoticons
    ```
    rpmbuild -ba kf5-kemoticons.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kemoticons-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kemoticons-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kemoticons-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kemoticons-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kemoticons-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kemoticons-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kemoticons-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kplotting
    ```
    rpmbuild -ba kf5-kplotting.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kplotting-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kplotting-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kplotting-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kplotting-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kplotting-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kplotting-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kplotting-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kdesignerplugin
    ```
    rpmbuild -ba kf5-kdesignerplugin.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kdesignerplugin-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesignerplugin-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesignerplugin-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesignerplugin-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdesignerplugin-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-syntax-highlighting
    ```
    rpmbuild -ba kf5-syntax-highlighting.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-syntax-highlighting-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-syntax-highlighting-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-syntax-highlighting-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-syntax-highlighting-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-syntax-highlighting-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-syntax-highlighting-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-syntax-highlighting-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install grantlee
    ```
    rpmbuild -ba grantlee.spec
    Wrote: /root/rpmbuild/SRPMS/grantlee-0.5.1-17.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-0.5.1-17.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-devel-0.5.1-17.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-debugsource-0.5.1-17.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-debuginfo-0.5.1-17.el8.x86_64.rpm
    ```
- install grantlee-qt5
```
rpmbuild -ba grantlee-qt5.spec
Wrote: /root/rpmbuild/SRPMS/grantlee-qt5-5.2.0-8.el8.src.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-qt5-5.2.0-8.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-qt5-devel-5.2.0-8.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/noarch/grantlee-qt5-apidocs-5.2.0-8.el8.noarch.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-qt5-debugsource-5.2.0-8.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/grantlee-qt5-debuginfo-5.2.0-8.el8.x86_64.rpm
rpm -ivh /root/rpmbuild/RPMS/x86_64/grantlee-qt5-5.2.0-8.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/grantlee-qt5-devel-5.2.0-8.el8.x86_64.rpm
```
- install kf5-kpimtextedit
    ```
    rpmbuild -ba kf5-kpimtextedit.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-kpimtextedit-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpimtextedit-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpimtextedit-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpimtextedit-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpimtextedit-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-kpimtextedit-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kpimtextedit-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-kparts
    ```
    rpmbuild -ba kf5-kparts.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kparts-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kparts-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kparts-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kparts-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kparts-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kparts-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kparts-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kunitconversion
    ```
    Wrote: /root/rpmbuild/SRPMS/kf5-kunitconversion-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kunitconversion-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kunitconversion-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kunitconversion-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kunitconversion-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kunitconversion-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kunitconversion-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kitemmodels
    ```
    rpmbuild -ba kf5-kitemmodels.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kitemmodels-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemmodels-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemmodels-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemmodels-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kitemmodels-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kitemmodels-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kitemmodels-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kdelibs4support
    ```
    rpmbuild -ba kf5-kdelibs4support.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kdelibs4support-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-libs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kf5-kdelibs4support-doc-5.73.0-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-debuginfo-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-libs-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-libs-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/kf5-kdelibs4support-doc-5.73.0-1.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/kf5-kdelibs4support-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kidentitymanagement
    ```
    rpmbuild -ba kf5-kidentitymanagement.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kidentitymanagement-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidentitymanagement-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidentitymanagement-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidentitymanagement-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kidentitymanagement-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kidentitymanagement-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kidentitymanagement-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install kf5-kcalendarutils
    ```
    rpmbuild -ba kf5-kcalendarutils.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcalendarutils-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarutils-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarutils-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarutils-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcalendarutils-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kcalendarutils-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kcalendarutils-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install libaccounts-qt
    ```
    dnf install "pkgconfig(libaccounts-glib)" -y
    rpmbuild -ba libaccounts-qt.spec
    Wrote: /root/rpmbuild/SRPMS/libaccounts-qt-1.16-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaccounts-qt5-1.16-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaccounts-qt5-devel-1.16-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/libaccounts-qt-doc-1.16-2.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaccounts-qt-debugsource-1.16-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libaccounts-qt5-debuginfo-1.16-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/libaccounts-qt5-1.16-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/libaccounts-qt5-devel-1.16-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/libaccounts-qt-doc-1.16-2.el8.noarch.rpm
    ```

- install kf5-kpackage
    ```
    rpmbuild -ba kf5-kpackage.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kpackage-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpackage-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpackage-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpackage-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpackage-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kpackage-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kpackage-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kdeclarative
    ```
    rpmbuild -ba kf5-kdeclarative.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kdeclarative-5.73.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdeclarative-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdeclarative-devel-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdeclarative-debugsource-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdeclarative-debuginfo-5.73.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdeclarative-5.73.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kdeclarative-devel-5.73.0-2.el8.x86_64.rpm
    ```

- install kf5-kcmutils
    ```
    rpmbuild -ba kf5-kcmutils.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kcmutils-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcmutils-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcmutils-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcmutils-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kcmutils-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kcmutils-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kcmutils-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install signon
    ```
    rpmbuild -ba signon.spec
    Wrote: /root/rpmbuild/SRPMS/signon-8.60-6.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-8.60-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-devel-8.60-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/signon-doc-8.60-6.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-debugsource-8.60-6.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-debuginfo-8.60-6.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/signon-8.60-6.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/signon-devel-8.60-6.el8.x86_64.rpm
    ```
- install signon-plugin-oauth2
    ```
    rpmbuild -ba signon-plugin-oauth2.spec 
    Wrote: /root/rpmbuild/SRPMS/signon-plugin-oauth2-0.22-13.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-plugin-oauth2-0.22-13.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-plugin-oauth2-devel-0.22-13.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-plugin-oauth2-debugsource-0.22-13.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/signon-plugin-oauth2-debuginfo-0.22-13.el8.x86_64.rpm
    rpm -ivh   /root/rpmbuild/RPMS/x86_64/signon-plugin-oauth2-0.22-13.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/signon-plugin-oauth2-devel-0.22-13.el8.x86_64.rpm
    ```
- install accounts-qml-module
    ```
    rpmbuild -ba accounts-qml-module.spec
    Wrote: /root/rpmbuild/SRPMS/accounts-qml-module-0.7-3.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/accounts-qml-module-0.7-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/accounts-qml-module-doc-0.7-3.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/accounts-qml-module-debugsource-0.7-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/accounts-qml-module-debuginfo-0.7-3.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/accounts-qml-module-0.7-3.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/accounts-qml-module-doc-0.7-3.el8.noarch.rpm
    ```
- install kaccounts-integration
```
rpmbuild -ba kaccounts-integration.spec
Wrote: /root/rpmbuild/SRPMS/kaccounts-integration-20.08.1-1.el8.src.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kaccounts-integration-20.08.1-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kaccounts-integration-devel-20.08.1-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kaccounts-integration-debugsource-20.08.1-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kaccounts-integration-debuginfo-20.08.1-1.el8.x86_64.rpm
rpm -ivh /root/rpmbuild/RPMS/x86_64/kaccounts-integration-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kaccounts-integration-devel-20.08.1-1.el8.x86_64.rpm
```
- install kf5-kmime
    ```
    rpmbuild -ba kf5-kmime.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kmime-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmime-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ihv /root/rpmbuild/RPMS/x86_64/kf5-kmime-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kmime-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install kf5-prison
    ```
    dnf install "pkgconfig(libdmtx)" "pkgconfig(libqrencode)"
    rpmbuild -ba kf5-prison.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-prison-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-prison-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-prison-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-prison-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-prison-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-prison-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-prison-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-akonadi-server
    ```
    dnf install mariadb-server postgresql-server -y
    rpmbuild -ba kf5-akonadi-server.spec 
    Wrote: /root/rpmbuild/SRPMS/kf5-akonadi-server-20.08.1-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-20.08.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-devel-20.08.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-mysql-20.08.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-debugsource-20.08.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-debuginfo-20.08.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-devel-debuginfo-20.08.1-2.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-20.08.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-devel-20.08.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-akonadi-server-mysql-20.08.1-2.el8.x86_64.rpm
    ```

- install kf5-akonadi-mime
    ```
    dnf install -y cyrus-sasl-devel
    rpmbuild -ba kf5-akonadi-mime.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-akonadi-mime-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-debuginfo-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-devel-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh   /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-akonadi-mime-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-akonadi-contacts
```
rpmbuild -ba kf5-akonadi-contacts.spec
Wrote: /root/rpmbuild/SRPMS/kf5-akonadi-contacts-20.08.1-1.el8.src.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-contacts-20.08.1-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-contacts-devel-20.08.1-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-contacts-debugsource-20.08.1-1.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-contacts-debuginfo-20.08.1-1.el8.x86_64.rpm
rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-akonadi-contacts-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-akonadi-contacts-devel-20.08.1-1.el8.x86_64.rpm
```

- install  kf5-ksmtp-devel
    ```
    dnf install  "cyrus-sasl-plain(x86-64)" -y
    rpmbuild -ba kf5-ksmtp.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-ksmtp-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ksmtp-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ksmtp-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ksmtp-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ksmtp-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-ksmtp-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-ksmtp-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install libkgapi
    ```
    rpmbuild -ba libkgapi.spec
    Wrote: /root/rpmbuild/SRPMS/libkgapi-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkgapi-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkgapi-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkgapi-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkgapi-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/libkgapi-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/libkgapi-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-kmailtransport
    ```
    rpmbuild -ba kf5-kmailtransport.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kmailtransport-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-akonadi-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-debuginfo-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-akonadi-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-akonadi-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kmailtransport-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install  kf5-akonadi-calendar
    ```
    Wrote: /root/rpmbuild/SRPMS/kf5-akonadi-calendar-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-calendar-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-calendar-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-calendar-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-calendar-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-akonadi-calendar-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-akonadi-calendar-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install kf5-libkcddb
    ```
    rpmbuild -ba kf5-libkcddb.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-libkcddb-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcddb-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcddb-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kf5-libkcddb-doc-20.08.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcddb-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcddb-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-libkcddb-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-libkcddb-devel-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/kf5-libkcddb-doc-20.08.1-1.el8.noarch.rpm
    ```

- install kf5-libkcompactdisc
    ```
    rpmbuild -ba kf5-libkcompactdisc.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-libkcompactdisc-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcompactdisc-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcompactdisc-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcompactdisc-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkcompactdisc-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-libkcompactdisc-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-libkcompactdisc-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-audiocd-kio
    ```
    dnf install -y cdparanoia cdparanoia-devel "pkgconfig(libmusicbrainz5)"
    rpmbuild -ba kf5-audiocd-kio.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-audiocd-kio-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-audiocd-kio-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-audiocd-kio-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kf5-audiocd-kio-doc-20.08.1-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-audiocd-kio-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-audiocd-kio-debuginfo-20.08.1-1.el8.x86_64.rpm

    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-audiocd-kio-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-audiocd-kio-devel-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/kf5-audiocd-kio-doc-20.08.1-1.el8.noarch.rpm
    ```
- install kf5-akonadi-notes
    ```
    rpmbuild -ba kf5-akonadi-notes.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-akonadi-notes-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-notes-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-notes-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-notes-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-notes-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-akonadi-notes-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-akonadi-notes-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install kf5-kholidays
    ```
    rpmbuild -ba kf5-kholidays.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kholidays-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kholidays-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kholidays-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kholidays-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kholidays-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -vih /root/rpmbuild/RPMS/x86_64/kf5-kholidays-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kholidays-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-kmbox
    ```
    rpmbuild -ba kf5-kmbox.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kmbox-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmbox-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmbox-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmbox-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kmbox-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kmbox-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kmbox-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-kldap
    ```
    dnf install openldap-devel -y 
    rpmbuild -ba kf5-kldap.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kldap-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kldap-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kldap-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kldap-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kldap-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kldap-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kldap-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install kf5-knewstuff
    ```
    rpmbuild -ba kf5-knewstuff.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-knewstuff-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knewstuff-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knewstuff-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knewstuff-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knewstuff-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-knewstuff-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-knewstuff-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kirigami2
    ```
    rpmbuild -ba kf5-kirigami2.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kirigami2-5.73.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kirigami2-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kirigami2-devel-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kirigami2-debugsource-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kirigami2-debuginfo-5.73.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kirigami2-5.73.0-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kirigami2-devel-5.73.0-2.el8.x86_64.rpm
    ```

- install kf5-kpeople
    ```
    rpmbuild -ba kf5-kpeople.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kpeople-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpeople-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpeople-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpeople-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpeople-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kpeople-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kpeople-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install plasma-wayland-protocols
    ```
    rpmbuild -ba plasma-wayland-protocols.spec
    Wrote: /root/rpmbuild/SRPMS/plasma-wayland-protocols-1.1.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-wayland-protocols-1.1.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-wayland-protocols-devel-1.1.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/plasma-wayland-protocols-1.1.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/plasma-wayland-protocols-devel-1.1.1-1.el8.x86_64.rpm
    ```
- install kf5-kwayland
    ```
    rpmbuild -ba kf5-kwayland.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kwayland-5.73.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwayland-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwayland-devel-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwayland-debugsource-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kwayland-debuginfo-5.73.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kwayland-5.73.0-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kwayland-devel-5.73.0-2.el8.x86_64.rpm
    ```
- install qca 
    ```
    dnf install doxygen-latex "pkgconfig(botan-2)" "pkgconfig(libpkcs11-helper-1)"
    rpmbuild -ba Qca.spec 
    Wrote: /root/rpmbuild/SRPMS/qca-2.3.1-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/qca-doc-2.3.1-2.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-devel-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-botan-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-cyrus-sasl-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-gcrypt-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-gnupg-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-logger-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-nss-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-ossl-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-pkcs11-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-softstore-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-debugsource-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-botan-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-cyrus-sasl-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-gcrypt-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-gnupg-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-logger-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-nss-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-ossl-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-pkcs11-debuginfo-2.3.1-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/qca-qt5-softstore-debuginfo-2.3.1-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/SRPMS/qca-2.3.1-2.el8.src.rpm /root/rpmbuild/RPMS/noarch/qca-doc-2.3.1-2.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-devel-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-botan-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-cyrus-sasl-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-gcrypt-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-gnupg-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-logger-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-nss-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-ossl-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-pkcs11-2.3.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qca-qt5-softstore-2.3.1-2.el8.x86_64.rpm
    ```
- install kf5-kactivities
    ```
    rpmbuild -ba kf5-kactivities.spec

    Wrote: /root/rpmbuild/SRPMS/kf5-kactivities-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kactivities-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kactivities-devel-5.73.0-1.el8.x86_64.rpm
    ```
- installkf5-kpty
    ```
    dnf install libutempter-devel -y
    rpmbuild -ba kf5-kpty.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kpty-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpty-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpty-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpty-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kpty-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kpty-5.73.0-1.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/kf5-kpty-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kdesu
    ```
    rpmbuild -ba kf5-kdesu.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kdesu-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesu-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesu-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesu-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdesu-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdesu-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kdesu-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kactivities-stats
    ```
    rpmbuild -ba kf5-kactivities-stats.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kactivities-stats-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-stats-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-stats-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-stats-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kactivities-stats-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kactivities-stats-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kactivities-stats-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kjs
    ```
    rpmbuild -ba kf5-kjs.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kjs-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjs-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjs-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjs-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjs-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kjs-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kjs-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kjsembed
    ```
    rpmbuild -ba kf5-kjsembed.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kjsembed-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjsembed-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjsembed-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjsembed-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kjsembed-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kjsembed-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kjsembed-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-knotifyconfig
    ```
    rpmbuild -ba kf5-knotifyconfig.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-knotifyconfig-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifyconfig-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifyconfig-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifyconfig-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-knotifyconfig-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-knotifyconfig-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-knotifyconfig-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-threadweaver
    ```
    rpmbuild -ba kf5-threadweaver
    Wrote: /root/rpmbuild/SRPMS/kf5-threadweaver-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-threadweaver-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-threadweaver-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-threadweaver-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-threadweaver-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-threadweaver-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-threadweaver-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-plasma
    ```
    rpmbuild -ba kf5-plasma.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-plasma-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-plasma-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-plasma-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-plasma-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-plasma-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-plasma-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-plasma-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-krunner
    ```
    rpmbuild -ba kf5-krunner.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-krunner-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-krunner-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-krunner-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install libksysguard
    ```
    rpmbuild -ba libksysguard.spec 
    Wrote: /root/rpmbuild/SRPMS/libksysguard-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libksysguard-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libksysguard-devel-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libksysguard-common-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libksysguard-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libksysguard-debuginfo-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libksysguard-common-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/libksysguard-5.19.5-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/libksysguard-devel-5.19.5-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/libksysguard-common-5.19.5-1.el8.x86_64.rpm
    ```
- install kf5-ktexteditor
    ```
    dnf install -y "pkgconfig(libgit2)"
    rpmbuild -ba kf5-ktexteditor.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-ktexteditor-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktexteditor-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktexteditor-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktexteditor-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-ktexteditor-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-ktexteditor-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-ktexteditor-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-kxmlrpcclient
    ```
    rpmbuild -ba kf5-kxmlrpcclient.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kxmlrpcclient-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlrpcclient-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlrpcclient-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlrpcclient-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kxmlrpcclient-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kxmlrpcclient-5.73.0-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kxmlrpcclient-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-networkmanager-qt
    ```
    dnf install "pkgconfig(libnm)" -y
    rpmbuild -ba kf5-networkmanager-qt.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-networkmanager-qt-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-networkmanager-qt-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-networkmanager-qt-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-networkmanager-qt-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-networkmanager-qt-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-networkmanager-qt-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-networkmanager-qt-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kscreenlocker
    ```
    rpmbuild -ba kscreenlocker.spec
    Wrote: /root/rpmbuild/SRPMS/kscreenlocker-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kscreenlocker-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kscreenlocker-devel-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kscreenlocker-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kscreenlocker-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kscreenlocker-5.19.5-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kscreenlocker-devel-5.19.5-1.el8.x86_64.rpm
    ```

- install libkscreen-qt5
    ```
    rpmbuild -ba libkscreen-qt5.spec
    Wrote: /root/rpmbuild/SRPMS/libkscreen-qt5-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkscreen-qt5-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkscreen-qt5-devel-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkscreen-qt5-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkscreen-qt5-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/libkscreen-qt5-5.19.5-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/libkscreen-qt5-devel-5.19.5-1.el8.x86_64.rpm
    ```
- install kdecoration
    ```
    rpmbuild -ba kdecoration.spec
    Wrote: /root/rpmbuild/SRPMS/kdecoration-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdecoration-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdecoration-devel-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdecoration-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdecoration-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kdecoration-5.19.5-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kdecoration-devel-5.19.5-1.el8.x86_64.rpm
    ```
- install kwayland
    ```
    rpmbuild -ba kwayland.spec
    Wrote: /root/rpmbuild/SRPMS/kwayland-server-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-server-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-server-devel-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-server-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-server-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kwayland-server-5.19.5-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kwayland-server-devel-5.19.5-1.el8.x86_64.rpm
    ```

- install kwayland-integration
    ```
    rpmbuild -ba kwayland-integration.spec
    Wrote: /root/rpmbuild/SRPMS/kwayland-integration-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-integration-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-integration-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwayland-integration-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kwayland-integration-5.19.5-1.el8.x86_64.rpm 
    ```

- install kf5-frameworkintegration
    ```
    rpmbuild -ba kf5-frameworkintegration.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-frameworkintegration-5.73.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-libs-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-devel-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-debugsource-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-debuginfo-5.73.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-libs-debuginfo-5.73.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-5.73.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-libs-5.73.0-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-frameworkintegration-devel-5.73.0-2.el8.x86_64.rpm
    ```
- install plasma-breeze
    ```
    dnf install -y fftw-devel
    rpmbuild -ba     plasma-breeze.spec    
    Wrote: /root/rpmbuild/SRPMS/plasma-breeze-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-breeze-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/plasma-breeze-common-5.19.5-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/breeze-cursor-theme-5.19.5-1.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-breeze-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-breeze-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/plasma-breeze-5.19.5-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/plasma-breeze-common-5.19.5-1.el8.noarch.rpm  /root/rpmbuild/RPMS/noarch/breeze-cursor-theme-5.19.5-1.el8.noarch.rpm
    ```
- install kwin
    ```
    dnf install xorg-x11-server-Xorg openbox -y
    rpmbuild -ba kwin.spec
    Wrote: /root/rpmbuild/SRPMS/kwin-5.19.5-4.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-wayland-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kwin-wayland-nvidia-5.19.5-4.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-x11-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-common-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-libs-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-devel-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/kwin-doc-5.19.5-4.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-debugsource-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-debuginfo-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-wayland-debuginfo-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-x11-debuginfo-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-common-debuginfo-5.19.5-4.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kwin-libs-debuginfo-5.19.5-4.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/SRPMS/kwin-5.19.5-4.el8.src.rpm /root/rpmbuild/RPMS/x86_64/kwin-5.19.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kwin-wayland-5.19.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/kwin-wayland-nvidia-5.19.5-4.el8.noarch.rpm /root/rpmbuild/RPMS/x86_64/kwin-x11-5.19.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kwin-common-5.19.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kwin-libs-5.19.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kwin-devel-5.19.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/kwin-doc-5.19.5-4.el8.noarch.rpm

    ```
- install libkworkspace5

- install plasma-workspace
    ```
    dnf install -y gpsd-devel libbsd-devel libqalculate-devel
    rpmbuild -ba plasma-workspace.spec
    Wrote: /root/rpmbuild/SRPMS/plasma-workspace-5.19.5-3.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-common-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkworkspace5-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-libs-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-devel-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/plasma-workspace-doc-5.19.5-3.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-geolocation-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-geolocation-libs-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/noarch/sddm-breeze-5.19.5-3.el8.noarch.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-wayland-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-xorg-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-debugsource-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-debuginfo-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/libkworkspace5-debuginfo-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-libs-debuginfo-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-geolocation-debuginfo-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-geolocation-libs-debuginfo-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-wayland-debuginfo-5.19.5-3.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/plasma-workspace-xorg-debuginfo-5.19.5-3.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/plasma-workspace-devel-5.19.5-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/plasma-workspace-libs-5.19.5-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/plasma-workspace-common-5.19.5-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/libkworkspace5-5.19.5-3.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/plasma-workspace-geolocation-libs-5.19.5-3.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/plasma-workspace-geolocation-5.19.5-3.el8.x86_64.rpm
    ```
- install kde-cli-tools
    ```
    rpmbuild -ba kde-cli-tools.spec 
    Wrote: /root/rpmbuild/SRPMS/kde-cli-tools-5.19.5-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-cli-tools-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdesu-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-cli-tools-debugsource-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-cli-tools-debuginfo-5.19.5-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdesu-debuginfo-5.19.5-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kde-cli-tools-5.19.5-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kdesu-5.19.5-1.el8.x86_64.rpm
    ```

- install kde-connect
    ```
    dnf install fuse-sshfs -y
    rpmbuild -ba kde-connect.spec
    Wrote: /root/rpmbuild/SRPMS/kde-connect-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-connect-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdeconnectd-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-connect-libs-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-connect-nautilus-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-connect-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-connect-debuginfo-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdeconnectd-debuginfo-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kde-connect-libs-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kde-connect-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kdeconnectd-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kde-connect-libs-20.08.1-1.el8.x86_64.rpm 
    ```

- install kf5-purpose
    ```
    rpmbuild -ba kf5-purpose.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-purpose-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-purpose-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-purpose-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-purpose-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-purpose-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-purpose-5.73.0-1.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/kf5-purpose-devel-5.73.0-1.el8.x86_64.rpm
    ```

- install kf5-krunner
    ```
    rpmbuild -ba kf5-krunner.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-krunner-5.73.0-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-devel-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-debugsource-5.73.0-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-krunner-debuginfo-5.73.0-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-krunner-5.73.0-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-krunner-devel-5.73.0-1.el8.x86_64.rpm
    ```
- install kf5-akonadi-search
    ```
    dnf install xapian-core-devel -y
    Wrote: /root/rpmbuild/SRPMS/kf5-akonadi-search-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-search-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-search-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-search-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-akonadi-search-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-akonadi-search-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-akonadi-search-devel-20.08.1-1.el8.x86_64.rpm
    ```

- install kf5-kimap
    ```
    rpmbuild -ba kf5-kimap.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kimap-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kimap-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kimap-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kimap-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kimap-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kimap-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-kimap-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-libkdepim
    ```
    Wrote: /root/rpmbuild/SRPMS/kf5-libkdepim-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkdepim-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkdepim-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkdepim-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-libkdepim-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-libkdepim-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-libkdepim-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-pimcommon
    ```
    rpmbuild -ba kf5-pimcommon.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-pimcommon-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-akonadi-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-debuginfo-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-akonadi-debuginfo-20.08.1-1.el8.x86_64.rpm
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-akonadi-20.08.1-1.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-pimcommon-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install kf5-grantleetheme
    ```
    rpmbuild -ba kf5-grantleetheme.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-grantleetheme-20.08.1-1.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-grantleetheme-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-grantleetheme-devel-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-grantleetheme-debugsource-20.08.1-1.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-grantleetheme-debuginfo-20.08.1-1.el8.x86_64.rpm

    rpm -vvh /root/rpmbuild/RPMS/x86_64/kf5-grantleetheme-20.08.1-1.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kf5-grantleetheme-devel-20.08.1-1.el8.x86_64.rpm
    ```
- install gpgme
```
rpmbuild -ba gpgme.spec
Wrote: /root/rpmbuild/SRPMS/gpgme-1.14.0-2.el8.src.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgme-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgme-devel-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgmepp-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgmepp-devel-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qgpgme-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qgpgme-devel-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/python3-gpg-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgme-debugsource-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgme-debuginfo-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgme-devel-debuginfo-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/gpgmepp-debuginfo-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/qgpgme-debuginfo-1.14.0-2.el8.x86_64.rpm
Wrote: /root/rpmbuild/RPMS/x86_64/python3-gpg-debuginfo-1.14.0-2.el8.x86_64.rpm

rpm -ivh  /root/rpmbuild/RPMS/x86_64/gpgme-devel-1.14.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/gpgme-1.14.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qgpgme-1.14.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/qgpgme-devel-1.14.0-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/gpgmepp-1.14.0-2.el8.x86_64.rpm
- install kf5-libkleo
```
rpmbuild -ba kf5-libkleo.spec



- install kdepim-apps-libs
        cmake(KF5Libkleo) is needed by kdepim-apps-libs-20.08.1-1.el8.x86_64
        cmake(QGpgme) is needed by kdepim-apps-libs-20.08.1-1.el8.x86_64
        kf5-libkleo-devel >= 20.08.1 is needed by kdepim-apps-libs-20.08.1-1.el8.x86_64

- install kf5-calendarsupport
        kdepim-apps-libs-devel >= 20.08.1 is needed by kf5-calendarsupport-20.08.1-1.el8.x86_64

- install kf5-kdgantt2
    ```
    rpmbuild -ba kf5-kdgantt2.spec
    Wrote: /root/rpmbuild/SRPMS/kf5-kdgantt2-16.08.3-10.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdgantt2-16.08.3-10.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdgantt2-devel-16.08.3-10.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdgantt2-debugsource-16.08.3-10.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kf5-kdgantt2-debuginfo-16.08.3-10.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kf5-kdgantt2-16.08.3-10.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/kf5-kdgantt2-devel-16.08.3-10.el8.x86_64.rpm
    ```
- install kdiagram
    ```
    rpmbuild -ba kdiagram.spec
    Wrote: /root/rpmbuild/SRPMS/kdiagram-2.7.0-2.el8.src.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdiagram-2.7.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdiagram-devel-2.7.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdiagram-debugsource-2.7.0-2.el8.x86_64.rpm
    Wrote: /root/rpmbuild/RPMS/x86_64/kdiagram-debuginfo-2.7.0-2.el8.x86_64.rpm
    rpm -ivh /root/rpmbuild/RPMS/x86_64/kdiagram-2.7.0-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/kdiagram-devel-2.7.0-2.el8.x86_64.rpm
    ```
- install kf5-eventviews
```
        cmake(KF5CalendarSupport) is needed by kf5-eventviews-20.08.1-1.el8.x86_64
        kf5-calendarsupport-devel >= 20.08.1 is needed by kf5-eventviews-20.08.1-1.el8.x86_64

        sed -i -e  's/cmake_build/make_build/g'  -e 's/cmake_install/make_install/g' *.spec