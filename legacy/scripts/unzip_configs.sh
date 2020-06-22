##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#####                                                       #####
##### This script exports the config programs from zip's    #####
##### and inserts the config files at the right place       #####
#####                                                       #####
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

imatch="--thunderbird"
# Only do this if argument --thunderbird is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    if [ ! -f ../encrypted_configs/thunderbird.zip.gpg ]; then
	echo "Thunderbird config file not found"
	exit
    fi
    # Copy the relevant data to tmp folder
    mkdir -p /tmp/notencrypted_configs/thunderbird/
    cp ../encrypted_configs/thunderbird.zip.gpg /tmp/decrypted_configs/
    # unzip file
    unzip /tmp/decrypted_configs/thunderbird.zip.gpg /tmp/decrypted_configs/thunderbird.zip
    cp -r ~/.thunderbird/Profiles/ /tmp/notencrypted_configs/thunderbird/Profiles/
fi
