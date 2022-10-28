TARGET=$1
BUILD_DIR=./build_$TARGET
BASE=$PWD

if [ $# -ne 2 ]
then
	echo Usage: $0 "[target]" "[dir]"
	echo
	echo For target choose one of:
	echo   c5     - Cyclone 5
	echo   a10    - Arria 10
	echo   s10    - Stratix 10
	echo
	echo dir is the target directory where the yocto environment was generated.
	exit 1
fi

if [ ! -d $2 ]
then
	echo Dir $2 does not exist.
	exit 1
fi

cd $2

. ./poky/oe-init-build-env $BUILD_DIR

cp $BASE/templates/svn.inc ./conf/
cp $BASE/templates/overrides.inc ./conf/
cp $BASE/templates/bblayers.conf ./conf/
cp $BASE/templates/local_$TARGET.conf ./conf/local.conf

cd ..
echo YOCTOROOT = \"$(pwd)\" >> $BUILD_DIR/conf/bblayers.conf

echo -------------------------------------------------------------------------------
echo Source Bitbake environment with . ./poky/oe-init-build-env $BUILD_DIR
echo Please update $BUILD_DIR/conf/svn.inc and $BUILD_DIR/conf/overrides.inc
