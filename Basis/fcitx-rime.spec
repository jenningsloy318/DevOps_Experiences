Name:           fcitx-rime
Version:        0.3.3
Release:        1%{?dist}
Summary:        RIME support for Fcitx




License:         GPL-3.0 License
URL:            https://github.com/fcitx/fcitx-rime
Source0:        https://github.com/fcitx/%{name}/archive/master.tar.gz#/%{name}-master.tar.gz

BuildArch:      x86_64

BuildRequires: fcitx-devel
BuildRequires: librime-devel
BuildRequires: fcitx-qt5-devel
BuildRequires: qt5-qtbase-devel
BuildRequires: brise

Requires: hicolor-icon-theme
Requires: fcitx
Requires: fcitx-libs
Requires: fcitx-data
Requires: fcitx-qt5
# explicitly requires brise (rime-data)
Requires: brise
Requires: fcitx-configtool
%description
RIME(中州韻輸入法引擎) is mainly a Traditional Chinese input method engine.




%prep

%setup -q -n %{name}-master
 
%build
export PATH=%{_qt5_bindir}:$PATH
mkdir cmake-build
pushd cmake-build
%{cmake3} ..
%{make_build}
popd 

%install
pushd cmake-build
%{make_install}  INSTALL_ROOT=%{buildroot} 
popd 

%files
%{_libdir}/fcitx/fcitx-rime.so
%{_libdir}/fcitx/qt/libfcitx-rime-config-gui.so
%{_datadir}/fcitx/addon/fcitx-rime.conf
%{_datadir}/fcitx/imicon/rime.png
%{_datadir}/fcitx/inputmethod/rime.conf
%{_datadir}/fcitx/skin/default/*
%{_datadir}/icons/hicolor/
%{_datadir}/locale/*/LC_MESSAGES/*
