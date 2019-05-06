name=$1
suffix=${name##*.}
pics=(jpg png JPG PNG jpeg JPEG)
if [ ! -f "$name" ]; then
        echo "File Not Exist"
elif [ $suffix == pdf ]; then
        evince $name &>/dev/null
elif echo "${pics[@]}" | grep -w $suffix &>/dev/null ; then
        deepin-image-viewer $name &>/dev/null &
else
        echo "File Type Not Supported"
        echo "See /mnt/d/Codes/OtherFiles/see.sh"
fi
