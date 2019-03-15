## nginx compilation parameters ##

Extral module:
- [nginx-module-vts](https://github.com/vozlt/nginx-module-vts)

## Build

use src rpm package to build , from nginx offical site

http://nginx.org/packages/centos/7/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm
http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-1.15.7-1.el7_4.ngx.src.rpm

## Modify nginx.spec
enable downloadable the sources
```
%undefine _disable_source_fetch
```

add vts module version and openssl version 
```
%define ngx_module_vts_version 0.1.18
%define ngx_openssl_version 1.1.1a
```

add buildrequirement for centos and sles
```
BuildRequires: openldap-devel
```
modiry WITH_CC_OPT, add path for libmyradclient-master required when build nginx-http-radius-module-master
```
%define WITH_CC_OPT $(echo %{optflags} $(pcre-config --cflags)) -fPIC  -I ./libmyradclient-master
```
modify compile parameters, append following code to `%define BASE_CONFIGURE_ARGS`
```
--add-module=./nginx-module-vts-%{ngx_module_vts_version} --with-openssl=./openssl-%{ngx_openssl_version} --add-module=./nginx_upstream_check_module-master --add-module=./nginx-auth-ldap-master --add-module=./nginx-http-radius-module-master
```

define vts,  openssl,  nginx_upstream_check_module source
```
Source14: https://github.com/vozlt/nginx-module-vts/archive/v%{ngx_module_vts_version}.tar.gz#/nginx-module-vts-%{ngx_module_vts_version}.tar.gz
Source15: https://openssl.org/source/openssl-%{ngx_openssl_version}.tar.gz#/openssl-%{ngx_openssl_version}.tar.gz
Source16: https://github.com/yaoweibin/nginx_upstream_check_module/archive/master.zip#/nginx_upstream_check_module-master.zip
source17: https://github.com/kvspb/nginx-auth-ldap/archive/master.zip#/nginx-auth-ldap-master.zip
source18: https://github.com/qudreams/libmyradclient/archive/master.zip#/libmyradclient-master.zip
source19: https://github.com/qudreams/nginx-http-radius-module/archive/master.zip#/nginx-http-radius-module-master.zip
```


modify `setup`, and pre-process libmyradclient-master
```
%setup -q -a 14 -a 15  -a 16 -a 17 -a 18 -a 19
ln -s libmyradclient-master libmyradclient && cd libmyradclient-master  && sed -i '/^CFLAGS=/s/$/ -fpic/g' Makefile && make && cp libmyradclient.a ../nginx-http-radius-module-master
```
