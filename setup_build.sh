TARGET=$1
BUILD_DIR=./build_$TARGET

if [ $# -ne 1 ]
then
	echo Single target parameter needed. Choose one of:
	echo   a10    - Arria 10
	echo   s10    - Stratix 10
	exit 1
fi

. ./poky/oe-init-build-env $BUILD_DIR

cp ../templates/svn.inc ./conf/
cp ../templates/bblayers.conf ./conf/
cp ../templates/local_$TARGET.conf ./conf/local.conf

cd ..
echo YOCTOROOT = \"$(pwd)\" >> $BUILD_DIR/conf/bblayers.conf

echo -------------------------------------------------------------------------------
echo Source Bitbake environment with . ./poky/oe-init-build-env $BUILD_DIR
echo Please update $BUILD_DIR/conf/svn.inc
