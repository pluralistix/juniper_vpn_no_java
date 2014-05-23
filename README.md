juniper_vpn_no_java
===================

run juniper vpn client without the java hassle

juniper_vpn_minimal.spec (from here)
juniper.sh (from here)
libncui.so ncdiag ncsvc version.txt (from your IT)

sudo yum -y install rpmdevtools

cd ~/rpmbuild/

copy the spec to SPECS/
copy the other files to SOURCES/

rpmbuild -ba SPECS/juniper_vpn_minimal.spec

sudo yum install RPMS/noarch/juniper_vpn_minimal-1-1.noarch.rpm

Then simply run

juniper.sh
