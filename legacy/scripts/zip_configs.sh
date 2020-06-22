##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####
#####                                                       #####
##### This script packages the config for specific programs #####
##### into zip files                                        #####
#####                                                       #####
##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

imatch="--thunderbird"
# Only do this if argument --thunderbird is supplied
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    # Copy the relevant data to tmp folder
    mkdir -p /tmp/notencrypted_configs/thunderbird/
    cp ~/.thunderbird/* /tmp/notencrypted_configs/thunderbird/
    cp -r ~/.thunderbird/Profiles/ /tmp/notencrypted_configs/thunderbird/Profiles/
    # Package to zip file
    zip -r ../encrypted_configs/thunderbird.zip /tmp/notencrypted_configs/thunderbird/
fi
