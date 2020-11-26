Build opencv 4.2 on CentOS 8
---

- install libdc1394-devel 
  ```
  dnf install libXv-devel libraw1394-devel -y
  rpmbuild -ba libdc1394.spec
  rpm -Uvh  /root/rpmbuild/RPMS/x86_64/libdc1394-2.2.2-12.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/libdc1394-devel-2.2.2-12.el8.x86_64.rpm
  ```

- install openni-devel
  ```
  dnf install  dos2unix freeglut-devel   graphviz  java-devel  jpackage-utils  tinyxml-devel python2
  rpmbuild -ba openni.spec
  rpm -ivh /root/rpmbuild/RPMS/x86_64/openni-devel-1.5.7.10-21.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/openni-1.5.7.10-21.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/openni-java-1.5.7.10-21.el8.x86_64.rpm
  ```

- install openni-primesense
  ```
  rpmbuild -ba openni-primesense.spec 

  rpm -ivh  /root/rpmbuild/RPMS/x86_64/openni-primesense-5.1.6.6-18.el8.x86_64.rpm
  ```
  - install SFML-devel
  ```
  dnf  install -y   flac-devel glew-devel libsndfile-devel libvorbis-devel openal-devel
  rpmbuild -ba SFML.spec
  rpm -ivh /root/rpmbuild/RPMS/x86_64/SFML-devel-2.5.1-3.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/SFML-2.5.1-3.el8.x86_64.rpm
  ```
- install  ceres-solver-devel
  ```
  dnf install -y atlas-devel gflags-devel glog-devel suitesparse-devel tbb-devel
  rpmbuild -ba ceres-solver.spec
  rpm -ivh  /root/rpmbuild/RPMS/x86_64/ceres-solver-1.13.0-12.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/ceres-solver-devel-1.13.0-12.el8.x86_64.rpm
  ```

- install coin-or-Clp-devel

	- install coin-or-Data-Netlib
    ```
    rpmbuild -ba coin-or-Data-Netlib.spec
    rpm -vih rpm -ivh /root/rpmbuild/RPMS/noarch/coin-or-Data-Netlib-1.2.9-2.el8.noarch.rpm
    ```
	- install coin-or-Sample
    ```
    rpmbuild -ba coin-or-Sample.spec
    rpm -ivh /root/rpmbuild/RPMS/noarch/coin-or-Sample-1.2.12-2.el8.noarch.rpm
    ```
	- install coin-or-CoinUtils
    ```
    dnf install glpk-devel openblas-devel -y
    rpmbuild -ba coin-or-CoinUtils.spec
    rpm -ivh  /root/rpmbuild/RPMS/x86_64/coin-or-CoinUtils-2.11.4-3.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/coin-or-CoinUtils-devel-2.11.4-3.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/coin-or-CoinUtils-doc-2.11.4-3.el8.x86_64.rpm
    ```
	- install coin-or-Osi
    ```
    rpmbuild -ba coin-or-Osi.spec
    rpm -ivh /root/rpmbuild/RPMS/x86_64/coin-or-Osi-0.108.6-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/coin-or-Osi-devel-0.108.6-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/coin-or-Osi-doc-0.108.6-2.el8.noarch.rpm
    ```
	
    - install coin-or-Clp-devel
		
    	- install coin-or-DyLP
            ```
  			rpmbuild -ba coin-or-DyLP.spec 
  			rpm -ivh /root/rpmbuild/RPMS/x86_64/coin-or-DyLP-1.10.4-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/coin-or-DyLP-devel-1.10.4-4.el8.x86_64.rpm /root/rpmbuild/RPMS/noarch/coin-or-DyLP-doc-1.10.4-4.el8.noarch.rpm
            ```
    	- install coin-or-Vol
    		```
            rpmbuild -ba coin-or-Vol.spec
    		rpm -ivh /root/rpmbuild/RPMS/x86_64/coin-or-Vol-1.5.4-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/coin-or-Vol-devel-1.5.4-4.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/coin-or-Vol-doc-1.5.4-4.el8.noarch.rpm
            ```
    	- install coin-or-Data-miplib3
    		```
            rpmbuild -ba coin-or-Data-miplib3.spec
    		rpm -ivh /root/rpmbuild/RPMS/noarch/coin-or-Data-miplib3-1.2.8-2.el8.noarch.rpm
            ```
    		- install cliquer
    		    ```
                rpmbuild -ba cliquer.spec
    			rpm -vih /root/rpmbuild/RPMS/x86_64/cliquer-1.21-19.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/cliquer-libs-1.21-19.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/cliquer-devel-1.21-19.el8.x86_64.rpm
                ```
    		- install nauty
    			```
                dnf install help2man -y
    			rpmbuild -ba nauty.spec
    			rpm -ivh  /root/rpmbuild/RPMS/x86_64/nauty-2.7.1-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/libnauty-2.7.1-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/libnauty-devel-2.7.1-2.el8.x86_64.rpm
                ```
    		- install mp-devel 
    			```
                dnf install -y chrpath cmake
    			rpmbuild -ba mp.spec
    			rpm -ivh /root/rpmbuild/RPMS/x86_64/mp-3.1.0-31.20200303git7fd4828.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/mp-devel-3.1.0-31.20200303git7fd4828.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/mp-doc-3.1.0-31.20200303git7fd4828.el8.x86_64.rpm
                ```
    		- install coin-or-Clp-devel
    			```
                dnf install -y readline-devel MUMPS-devel
    			rpmbuild -ba  coin-or-Clp.spec --with bootstrap
    			rpm -ivh /root/rpmbuild/RPMS/x86_64/coin-or-Clp-1.17.6-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/coin-or-Clp-devel-1.17.6-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/coin-or-Clp-doc-1.17.6-2.el8.noarch.rpm
                ```
    		- install coin-or-Cgl
    			```
                rpmbuild -ba coin-or-Cgl.spec
    			 rpm -ivh /root/rpmbuild/RPMS/x86_64/coin-or-Cgl-0.60.3-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/coin-or-Cgl-devel-0.60.3-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/coin-or-Cgl-doc-0.60.3-2.el8.noarch.rpm
                ```
    		- install coin-or-Cbc
    			```
                 rpmbuild -ba coin-or-Cbc.spec
    			rpm -ivh /root/rpmbuild/RPMS/x86_64/coin-or-Cbc-devel-2.10.5-4.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/coin-or-Cbc-2.10.5-4.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/coin-or-Cbc-doc-2.10.5-4.el8.noarch.rpm
                ```
    		- rebuilt coin-or-Clp-devel
    			```
                rpmbuild -ba  coin-or-Clp.spec --with bootstrap
    			rpm -Uvh /root/rpmbuild/RPMS/x86_64/coin-or-Clp-devel-1.17.6-2.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/coin-or-Clp-devel-1.17.6-2.el8.x86_64.rpm  /root/rpmbuild/RPMS/noarch/coin-or-Clp-doc-1.17.6-2.el8.noarch.rpm --force
                ```


- install gdcm-devel
	
	- install CharLS-devel
		```
        rpmbuild -ba CharLS.spec
		rpm -ihv  /root/rpmbuild/RPMS/x86_64/CharLS-2.0.0-4.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/CharLS-devel-2.0.0-4.el8.x86_64.rpm
        ```
		
    - install dcmtk-devel
		```
        dnf install openssl-devel -y
		rpmbuild -ba dcmtk.spec
        rpm -ivh /root/rpmbuild/RPMS/x86_64/dcmtk-3.6.4-8.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/dcmtk-devel-3.6.4-8.el8.x86_64.rpm
        ```
    - install docbook5-style-xsl
        ```
        rpmbuild -ba docbook5-style-xsl.spec
        rpm -ivh /root/rpmbuild/RPMS/noarch/docbook5-style-xsl-1.79.2-10.el8.noarch.rpm
        ```
	- install gdcm-devel
		```
        dnf install  -y gl2ps-devel libtheora-devel libxslt-devel mesa-libOSMesa-devel openssl-devel  swig "pkgconfig(libopenjp2)"
		rpmbuild -ba gdcm.spec
		rpm -ivh /root/rpmbuild/RPMS/x86_64/gdcm-3.0.7-5.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/gdcm-devel-3.0.7-5.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/gdcm-applications-3.0.7-5.el8.x86_64.rpm
        ```
- install gtkglext-devel
	```
    dnf install -y libXmu-devel
	rpmbuild -ba gtkglext.spec
	rpm -ivh /root/rpmbuild/RPMS/x86_64/gtkglext-libs-1.2.0-38.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/gtkglext-devel-1.2.0-38.el8.x86_64.rpm
    ```
	
- build opencv 4.2
    ```
	dnf install -y OpenEXR-devel SFML-devel ant blas-devel ceres-solver-devel chrpath coin-or-Clp-devel gdal-devel gdcm-devel gflags-devel glog-devel gstreamer1-devel gstreamer1-plugins-base-devel gtkglext-devel hdf5-devel jasper-devel lapack-devel libgphoto2-devel libmfx-devel libtheora-devel libucil-devel libv4l-devel libva-devel libvorbis-devel libwebp-devel openblas-devel opencl-headers openni-devel openni-primesense protobuf-devel pylint python3-flake8 python3-numpy swig tbb-devel vulkan-headers hdf5-devel opencl-headers
	rpmbuild -ba opencv-4.2.spec  --without vulkan --without cuda
	rpm -ivh /root/rpmbuild/RPMS/x86_64/opencv-4.2.0-5.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/opencv-core-4.2.0-5.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/opencv-devel-4.2.0-5.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/opencv-contrib-4.2.0-5.el8.x86_64.rpm
    ```



- final install 
    ```
    dnf install MUMPS glpk gdal suitesparse protobuf hdf5 OpenEXR-libs ilmbase libdc1394 libucil libunicap environment-modules -y 
    rpm -ivh /root/rpmbuild/RPMS/x86_64/opencv-4.2.0-5.el8.x86_64.rpm  /root/rpmbuild/RPMS/x86_64/opencv-core-4.2.0-5.el8.x86_64.rpm /root/rpmbuild/RPMS/x86_64/opencv-devel-4.2.0-5.el8.x86_64.rpm   /root/rpmbuild/RPMS/x86_64/opencv-contrib-4.2.0-5.el8.x86_64.rpm nauty-2.7.1-2.el8.x86_64.rpm libnauty-2.7.1-2.el8.x86_64.rpm  cliquer-libs-1.21-19.el8.x86_64.rpm  cliquer-1.21-19.el8.x86_64.rpm  coin-or-Clp-1.17.6-2.el8.x86_64.rpm coin-or-CoinUtils-2.11.4-3.el8.x86_64.rpm gdcm-applications-3.0.7-5.el8.x86_64.rpm gdcm-3.0.7-5.el8.x86_64.rpm  coin-or-Cbc-2.10.5-4.el8.x86_64.rpm  coin-or-Osi-0.108.6-2.el8.x86_64.rpm  CharLS-2.0.0-4.el8.x86_64.rpm  coin-or-Cgl-0.60.3-2.el8.x86_64.rpm 
    ```

