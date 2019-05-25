name=$1
suffix=${name##*.}
pics=(jpg png JPG PNG jpeg JPEG)
text=(R py Rmd tex java txt)
if [ ! -f "$name" ]; then
        echo "File Not Exist"
elif [ $suffix == pdf ]; then
        okular $name &>/dev/null &
elif echo "${pics[@]}" | grep -w $suffix &>/dev/null ; then
        gwenview $name &>/dev/null &
elif [ $suffix == csv ] || [ $2 == csv ]; then
        column -s, -t < $name | less -#2 -N -S
elif echo "${text[@]}" | grep -w $suffix &>/dev/null ; then
        kate $name &>/dev/null &
else
        echo "File Type Not Supported"
        echo "See /mnt/d/Codes/OtherFiles/see.sh"
fi
