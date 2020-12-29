
%global owner buggins
%global commit face2671e1690f56cbaaf97d390c7b9c4dcd1027
%global shortcommit %(c=%{commit}; echo ${c:0:7})

Name:           coolreader
Version:        3.2.51
Release:        1%{?dist}
Summary:        cross platform open source e-book reader


License:        GPL-2.0 License
URL:            https://github.com/%{owner}/%{name}
Source0:        https://github.com/%{owner}/%{name}/archive/%{commit}/%{name}-%{shortcommit}.tar.gz 

BuildArch:      x86_64

BuildRequires: qt5-qtbase-devel
BuildRequires: qt5-linguist
BuildRequires: make
BuildRequires: gcc-c++
BuildRequires: freetype-devel


%description
%{Summary} .




%prep

%autosetup -n %{name}-%{commit}
 
%build
export PATH=%{_qt5_bindir}:$PATH
mkdir cmake_build
pushd cmake_build
%{cmake} -D GUI=QT5 -D CMAKE_BUILD_TYPE=Release ..
%{make_build}
popd 

%install
pushd cmake_build
%{make_install}
popd

%files
%{_bindir}/*
#%{_includedir}/harfbuzz/
#%{_libdir}/cmake/harfbuzz/
#%{_libdir}/libharfbuzz.so
%{_datadir}/applications/*
%{_datadir}/cr3/
%{_docdir}/cr3/
%{_mandir}/man1/*
%{_datadir}/pixmaps/*

