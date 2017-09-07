#!/bin/sh

# to toggle debugging comment/uncomment the following:
set -x

# get necessary openWRT packages
opkg update
opkg install coreutils-sha1sum libstdcpp shadow-groupadd shadow-useradd shadow-su

# add kibana user, group, and home directories

mkdir /home "$KIBANA_HOME"
usr/sbin/useradd -d "/home/${KIBANA_USER}" -m -s /bin/bash -U "$KIBANA_USER"
cp /root/.bashrc "/home/$ELASTIC_USER"
echo 'alias hostname="echo $HOSTNAME"' >> /etc/profile

# download kibana 
wget -nv "${KIBANA_DOWNLOAD_URL}"

# download sha1 of above file
wget -nv "${KIBANA_DOWNLOAD_URL}.sha1"

# the sha1 according to elastic.co: 
SUM=$(cat "/${KIBANA_FILE}.sha1")

# extract hash from sha1sum, because this is how elastic.co stores the sha1 file (!)
newsum=$(echo $(sha1sum "/${KIBANA_FILE}") | cut -d ' ' -f 1)

if [ "$SUM" == "$newsum" ] && [ "$SUM" != "" ] 
then echo "SHA1SUM OK"
else echo "SHA1SUM FAILED!!!" 
     exit 1
fi

# install kibana:

tar -xvzf "/${KIBANA_FILE}"
mv -f /${KIBANA_ARTIFACT}/* "$KIBANA_HOME"

# aliasing the host name

sed -i '1s/$/\nalias hostname="echo $HOSTNAME"/' "${KIBANA_HOME}/bin/kibana"

# chown $kibana_home
chown -R "${KIBANA_USER}:${KIBANA_GROUP}" "$KIBANA_HOME"

# remove unecessary packages and files
rm /tmp/opkg-lists/* 
rm "/${KIBANA_FILE}"
rm "/${KIBANA_FILE}.sha1"

