#!/bin/bash

# Get args in array
args=("$@")



match="-h"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    echo "-h help"
    echo "-r random"
    echo "-t TAG tag to select from"
fi


declare -A wallpaper0=(
    [name]=''
    [path]='0245w5tp48241.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper1=(
    [name]=''
    [path]='425099.jpg'
    [tag]='hq, gaming, neon'
)
declare -A wallpaper2=(
    [name]=''
    [path]='539183.jpg'
    [tag]='neon, fantasy'
)
declare -A wallpaper3=(
    [name]=''
    [path]='5ojxtesbopm41.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper4=(
    [name]=''
    [path]='5yzpqs8t43731.png'
    [tag]='cartoon, hq, abstract'
)
declare -A wallpaper5=(
    [name]=''
    [path]='8bsf1dtgcs441.jpg'
    [tag]='hq, city, comic'
)
declare -A wallpaper6=(
    [name]=''
    [path]='e6030fac1126de27a7c9a61.png'
    [tag]='amongtrees, comic'
)
declare -A wallpaper7=(
    [name]=''
    [path]='eodk675sytm41.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper8=(
    [name]=''
    [path]='ihi1nuwhqqe11.jpg'
    [tag]='nature'
)
declare -A wallpaper9=(
    [name]=''
    [path]='ipda90h8dk311.jpg'
    [tag]='nature'
)
declare -A wallpaper10=(
    [name]=''
    [path]='jg7ly57xq6111.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper11=(
    [name]=''
    [path]='lghllrc86vdy.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper12=(
    [name]=''
    [path]='mvzdbpdd1j821.png'
    [tag]='neon, abstract, car, hq'
)
declare -A wallpaper13=(
    [name]=''
    [path]='nm3kc8kzwki01.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper14=(
    [name]=''
    [path]='nmuy0x4t4px41.png'
    [tag]='neon'
)
declare -A wallpaper15=(
    [name]=''
    [path]='q18vfzjgb5f21.jpg'
    [tag]='abstract, comic, hq'
)
declare -A wallpaper16=(
    [name]=''
    [path]='qjey2f2v0vmz.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper17=(
    [name]=''
    [path]='y3dh65c8r1041.jpg'
    [tag]='nature, hq'
)
declare -A wallpaper18=(
    [name]=''
    [path]='zw9f21487sk21.jpg'
    [tag]='nature, hq'
)

BASE_DIR="/usr/share/wallpapers/custom/"

TAGS=""
LISTEN=false
for i in "$@"; do
    if [ $LISTEN = true ]; then
        LISTEN=false
        # IFS=',' read -ra TAGS <<< "$i"
        TAGS=$i
    fi
    if [ $i = "-t" ]; then
        LISTEN=true
    fi
done

COUNT=0
PATHS=()
declare -n wallpaper
for wallpaper in ${!wallpaper@}; do
    if [ -f $BASE_DIR${wallpaper[path]} ]; then
        CURRENT_TAGS=""
        IFS=", " read -ra CURRENT_TAGS <<< "${wallpaper[tag]}"
        match=$TAGS
        if printf '%s\n' ${CURRENT_TAGS[@]} | grep -q -P '^'$match'$'; then
            (( COUNT++ ))
            PATHS+=($BASE_DIR${wallpaper[path]})
        fi
    fi
done

match="-r"
if printf '%s\n' ${args[@]} | grep -q -P '^'$match'$'; then
    NUM=$((RANDOM % $COUNT))
    feh --bg-scale ${PATHS[$NUM]}
fi

# declare -n wallpaper
# for w in ${!wallpaper@}; do
#     printf "${w[path]}"
# done
