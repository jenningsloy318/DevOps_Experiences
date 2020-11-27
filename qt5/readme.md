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
    rpm -ivh /root/rpmbuild/RPMS/noarch/extra-cmake-modules-5.73.0-1.el8.noarch.rpm
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