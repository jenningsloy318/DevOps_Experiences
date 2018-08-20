## nginx compilation parameters ##

Extral module:
- [nginx-module-vts](https://github.com/vozlt/nginx-module-vts)

## Build

use src rpm package to build , from nginx offical site

http://nginx.org/packages/centos/7/SRPMS/nginx-1.14.0-1.el7_4.ngx.src.rpm

## Modify nginx.spec

add vts module version and openssl version 
```
%define ngx_module_vts_version 0.1.18
%define ngx_openssl_version 1.1.0i
```

modify compile parameters, append following code to `%define BASE_CONFIGURE_ARGS`
```
--add-module=./nginx-module-vts-%{ngx_module_vts_version} --with-openssl=./openssl-%{ngx_openssl_version}
```

define vts and openssl source
```
Source14: https://github.com/vozlt/nginx-module-vts/archive/v%{ngx_module_vts_version}.tar.gz#/nginx-module-vts.tar.gz
Source15: https://openssl.org/source/openssl-%{ngx_openssl_version}.tar.gz
```


modify `setup`
```
%setup -q -a 14 -a 15
```


download vts and openssl to `SOURCES` directory

```
 curl -SL https://www.openssl.org/source/openssl-1.1.0i.tar.gz -o openssl-1.1.0i.tar.gz
 curl -SL https://github.com/vozlt/nginx-module-vts/archive/v0.1.18.tar.gz -o  nginx-module-vts.tar.gz
```