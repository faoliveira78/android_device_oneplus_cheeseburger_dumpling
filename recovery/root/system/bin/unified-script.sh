#!/system/bin/sh
# This script is needed to automatically set device props.


load_dumpling()
{
    resetprop "ro.product.model" "OnePlus A5010"
    resetprop "ro.product.name" "OnePlus5T"
    resetprop "ro.build.product" "OnePlus5T"
    resetprop "ro.product.device" "dumpling"
    resetprop "ro.vendor.product.device" "dumpling"
}

load_cheeseburger()
{
    resetprop "ro.product.model" "OnePlus A5000"
    resetprop "ro.product.name" "OnePlus5"
    resetprop "ro.build.product" "OnePlus5"
    resetprop "ro.product.device" "cheeseburger"
    resetprop "ro.vendor.product.device" "cheeseburger"
}

rf=$(getprop ro.boot.rf_version)
echo "Running unified/variant script with $rf..." >> /tmp/recovery.log

case $rf in
    21)
        load_dumpling
        ;;
    53)
        load_cheeseburger
        ;;
    *)
        load_dumpling
        ;;
esac

exit 0
