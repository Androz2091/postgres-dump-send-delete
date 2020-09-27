# Postgres Dump Send Delete

This script makes a dump of your PG database, then converts it to a tar file and sends it to a remote server. Once the transfer is done, the script will delete the dump from your server.

## Installation

* Install Curl. (`apt-get install curl`)
* Download the script. (`curl -O https://raw.githubusercontent.com/Androz2091/postgres-dump-send-delete/master/backup.sh`)
* Configure the script using a text editor.
* Setup ssh keys so `rsync` can be used to transfer files without typing the password.
* Setup Cron so the script is run every 6 hours. (`0 */6 * * * /bin/bash /path/to/backup.sh`)
* You're done.
