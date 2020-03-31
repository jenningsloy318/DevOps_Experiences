#My vimrc settings
>- contain the .vimrc file and a shell to setup the plugins


## build vim 

1. install depenency 
 - on centos8
   ```sh
   dnf --enablerepo=PowerTools  install  gcc make autoconf desktop-file-utils gcc gpm-devel gtk3-devel libICE-devel libSM-devel libX11-devel libXpm-devel libXt-devel libacl-devel libappstream-glib libselinux-devel lua-devel ncurses-devel python3-devel ruby ruby-devel perl-devel perl-ExtUtils-Embed perl-ExtUtils-ParseXS perl-generators
   ```
  - on centos 7 
    ```
    yum install -y  hunspell-devel gcc  make python3-devel ncurses-devel gettext perl-devel perl-generators perl-ExtUtils-Embed perl-ExtUtils-ParseXS libacl-devel gpm-devel autoconf file libselinux-devel ruby-devel ruby lua-devel desktop-file-utils  gtk3-devel libX11-devel libSM-devel libXt-devel libXpm-devel libICE-devel gtk3-devel libSM-devel libXt-devel libXpm-devel libappstream-glib
    ``` 
2. build rpm 
   ```
   rpmbuild -ba vim.spec --nocheck
   ```

3. https://src.fedoraproject.org/rpms/vim