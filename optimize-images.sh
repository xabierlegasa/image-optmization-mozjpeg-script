#!/usr/bin/env bash
# Script that optimizes images.


# Confirm prompt
function confirm() {

    local description=${1}
    local default=${2}
    local prompt="[y/N]"
    local response=default

    if [ "$default" = "Y" ]; then
        prompt="[Y/n]"
    else
        default="N"
    fi

    RED="\033[0;31m"
    NC="\033[0m" # No Color

    # assign std input to the keyboard and close it again after retrieving the response
    exec < /dev/tty
    RESET="\033[0m"
    BOLD="\033[1m"
    YELLOW="\033[38;5;11m"
    read -p "$(echo -e $BOLD$YELLOW" ${description} ${prompt} "$RESET)" response
    exec <&-

    if [ "$response" = "" ]; then
        response=${default}
    fi

    if [[ "$response" = "Y" ]] || [[ "$response" = "y" ]]; then
        result="Y"
    else
        result="N"
    fi

    echo ${result}
}


############ Get input parameters
folder="./web"
quality=80

for i in "$@"
do
    case $i in
        --quality=*|--q)
            quality="${i#*=}"
            shift # past argument
            ;;
        --folder=*|--f=*)
            folder="${i#*=}"
            shift # past argument
            ;;
        *)
            # unknown option
            ;;
    esac
done

echo "Searching for images to be optimized with mozjpeg algorithm..."
echo "Folder  = ${folder}"
echo "Quality = ${quality}"




############ Loop images and optimize them in necessary
counter=0
for i in $(find $folder -name "*.jpg");do
    echo
    echo "found image: $i"
    inputfile=$i

    if [ $(confirm "Would you like to optimize the image?") = "Y" ]
    then
        echo "optimizing image..."
        inputfilesize=$(wc -c <"$inputfile")
        optimizer $inputfile $quality
        outputfilesize=$(wc -c <"$inputfile")
        counter=$(($counter +1))

        # remove leading whitespaces
        inputfilesize="$(echo "${inputfilesize}" | sed -e 's/^[[:space:]]*//')"
        outputfilesize="$(echo "${outputfilesize}" | sed -e 's/^[[:space:]]*//')"

        if [ $inputfilesize != $outputfilesize ]
        then
            improvementPercentage=$(expr 100 - 100 \* $outputfilesize / $inputfilesize)
            improvementPercentage=${improvementPercentage#-}
            echo "image size is now $improvementPercentage % less. From $inputfilesize KB to $outputfilesize KB"
        else
            echo "image is already optimized: $inputfilesize KB"
        fi
    fi
done


if [ $counter -gt 0 ]
then
    # Fail
    echo
    echo "OK. $counter image(s) have been optimized."
fi


