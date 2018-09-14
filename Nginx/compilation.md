## nginx compilation parameters ##

Extral module:
- [nginx-module-vts](https://github.com/vozlt/nginx-module-vts)

## Build

use src rpm package to build , from nginx offical site

http://nginx.org/packages/centos/7/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm

## Modify nginx.spec
enable downloadable the sources
```
%undefine _disable_source_fetch
```

add vts module version and openssl version 
```
%define ngx_module_vts_version 0.1.18
%define ngx_openssl_version 1.1.1
```

modify compile parameters, append following code to `%define BASE_CONFIGURE_ARGS`
```
--add-module=./nginx-module-vts-%{ngx_module_vts_version} --with-openssl=./openssl-%{ngx_openssl_version} --add-module=./nginx_upstream_check_module-master"
```

define vts,  openssl,  nginx_upstream_check_module source
```
Source14: https://github.com/vozlt/nginx-module-vts/archive/v%{ngx_module_vts_version}.tar.gz#/nginx-module-vts-%{ngx_module_vts_version}.tar.gz
Source15: https://openssl.org/source/openssl-%{ngx_openssl_version}.tar.gz#/openssl-%{ngx_openssl_version}.tar.gz
Source16: https://github.com/yaoweibin/nginx_upstream_check_module/archive/master.zip#/nginx_upstream_check_module-master.zip
```


modify `setup`
```
%setup -q -a 14 -a 15  -a 16
```
