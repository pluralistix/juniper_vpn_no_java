%define _binaries_in_noarch_packages_terminate_build   0

Name:           juniper_vpn_minimal
Version:        1
Release:        1
Summary:        simple wrapper to start juniper vpn client without java

License:	GPL

BuildArch: 	noarch

Source0:        libncui.so
Source1:	ncdiag
Source2:	ncsvc
Source3:	version.txt
Source4:	juniper.sh

BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

Requires: openssl glibc(x86-32) zlib(x86-32) libgcc(x86-32)

%description

%install
rm -rf $RPM_BUILD_ROOT

%{__mkdir_p} ${RPM_BUILD_ROOT}/usr/local/nc/
%{__mkdir_p} ${RPM_BUILD_ROOT}%{_sbindir}/

%{__install} -m0755 %{SOURCE0} ${RPM_BUILD_ROOT}/usr/local/nc/
%{__install} -m0775 %{SOURCE1} ${RPM_BUILD_ROOT}/usr/local/nc/
%{__install} -m4711 %{SOURCE2} ${RPM_BUILD_ROOT}/usr/local/nc/
%{__install} -m0644 %{SOURCE3} ${RPM_BUILD_ROOT}/usr/local/nc/
%{__install} -m0755 %{SOURCE4} ${RPM_BUILD_ROOT}%{_sbindir}/

%files
%attr(755, root, root) /usr/local/nc/libncui.so
%attr(775, root, root) /usr/local/nc/ncdiag
%attr(4711, root, root) /usr/local/nc/ncsvc
%attr(644, root, root) /usr/local/nc/version.txt
%attr(755, root, root) %{_sbindir}/juniper.sh

%postun
rm -rf /usr/local/nc

%clean
rm -rf %{RPM_BUILD_ROOT}

%changelog
* Fri May 23 2014 pluralistix 
- 
