juniper_vpn_no_java
===================

run juniper vpn client without the java hassle

You need:

juniper_vpn_minimal.spec (from here)<br />
juniper.sh (from here)<br />
libncui.so ncdiag ncsvc version.txt (from your IT)<br />

sudo yum -y install rpmdevtools

cd ~/rpmbuild/

copy the spec to SPECS/
copy the other files to SOURCES/

rpmbuild -ba SPECS/juniper_vpn_minimal.spec

sudo yum install RPMS/noarch/juniper_vpn_minimal-1-1.noarch.rpm

Then simply run

juniper.sh
