Name:           count-files
Version:        2.0
Release:        1%{?dist}
Summary:        Script to count files in a directory

License:        MIT
URL:            https://github.com/IllyaBruy/linux-lab-scripts
Source0:        %{name}-%{version}.tar.gz

BuildArch:      noarch
Requires:       bash
Requires:       coreutils
Requires:       findutils
Requires:       gawk

%description
A Bash script that counts files in a directory.
Version 2.0 adds a configuration file and a man page.

%prep
%setup -q

%install
mkdir -p %{buildroot}%{_bindir}
mkdir -p %{buildroot}%{_sysconfdir}
mkdir -p %{buildroot}%{_mandir}/man1

install -m 755 count_files.sh %{buildroot}%{_bindir}/count_files
install -m 644 count-files.conf %{buildroot}%{_sysconfdir}/count-files.conf
install -m 644 count_files.1 %{buildroot}%{_mandir}/man1/count_files.1

%pre
echo "Installing count-files %{version}..."

%post
echo "count-files %{version} installed."
echo "Config: %{_sysconfdir}/count-files.conf"

%files
%{_bindir}/count_files
%config %{_sysconfdir}/count-files.conf
%{_mandir}/man1/count_files.1*

%changelog
* Mon Oct 05 2026 Illia Brui <levchenkoillya234@gmail.com> - 2.0-1
- Added config file and man page

* Mon Oct 05 2026 Illia Brui <levchenkoillya234@gmail.com> - 1.0-1
- Initial package release
