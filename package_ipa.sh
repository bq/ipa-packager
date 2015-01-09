#!/bin/bash
APP="$1"
IPA="$2"
TEMP_IPA_BUILT="/tmp/ipabuild"

if [ ! -d "${APP}" ]; then
    echo "Usage: sh package_ipa.sh PATH_TO_SIGNED_APP OUTPUT_IPA_PATH"
    exit 1
fi

echo "+ Packaging ${APP} into ${IPA}"

if [ -f "${IPA}" ];
then
    /bin/rm "${IPA}"
fi    
if [ -d "${TEMP_IPA_BUILT}" ];
then
    rm -rf "${TEMP_IPA_BUILT}"
fi  

echo "+ Preparing folder tree for IPA" 
mkdir -p "${TEMP_IPA_BUILT}/Payload"
cp -Rp "${APP}" "${TEMP_IPA_BUILT}/Payload"

echo "+ Adding SWIFT support (if necessary)"
if [ -d "${APP}/Frameworks" ];
then
    mkdir -p "${TEMP_IPA_BUILT}/SwiftSupport"

    for SWIFT_LIB in $(ls -1 "${APP}/Frameworks"); do 
        echo "Copying ${SWIFT_LIB}"
        cp "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/iphoneos/${SWIFT_LIB}" "${TEMP_IPA_BUILT}/SwiftSupport"
    done
fi

echo "+ zip --symlinks --verbose --recurse-paths ${IPA} ."
cd "${TEMP_IPA_BUILT}"
zip --symlinks --verbose --recurse-paths "${IPA}" .
cd -
cp "${TEMP_IPA_BUILT}/${IPA}" .
