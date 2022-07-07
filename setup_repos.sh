RELEASE=dunfell

if [ $# -ne 2 ]
then
	echo Usage: $0 "[prot]" "[dir]"
	echo
	echo For protocol prot choose one of:
	echo   ssh     - Use SSH for github
	echo   https   - Use HTTPS for github
	echo
	echo dir is the target directory where the yocto environment will be generated.
	exit 1
fi

case $1 in

	ssh)
		echo "Protocol: SSH"
		URL_POKY="git://git.yoctoproject.org/poky"
		URL_OE="git@github.com:openembedded/meta-openembedded.git"
		URL_TES="git@github.com:tes-gfx/meta-tes.git"
		URL_QT5="git@github.com:tes-gfx/meta-qt5.git"
		URL_ALTERA="git@github.com:tes-gfx/meta-altera.git"
		URL_ALTERA_UPSTREAM="git@github.com:kraj/meta-altera"
		URL_ARM="git@github.com:tes-gfx/meta-arm"
		URL_ARM_UPSTREAM="git://git.yoctoproject.org/meta-arm"
		;;

	https)
		echo "Protocol: HTTPS"
		URL_POKY="https://git.yoctoproject.org/git/poky"
		URL_OE="https://github.com/openembedded/meta-openembedded.git"
		URL_TES="https://github.com/tes-gfx/meta-tes.git"
		URL_QT5="https://github.com:tes-gfx/meta-qt5.git"
		URL_ALTERA="https://github.com/tes-gfx/meta-altera.git"
		URL_ALTERA_UPSTREAM="https://github.com/kraj/meta-altera"
		URL_ARM="https://github.com/tes-gfx/meta-arm"
		URL_ARM_UPSTREAM="https://git.yoctoproject.org/git/meta-arm"
		;;

	*)
		echo "Unsupported protocol:" $1
		exit 1
esac

mkdir -p $2
cd $2

git clone -b $RELEASE $URL_POKY

mkdir -p downloads
mkdir -p repos
pushd repos
git clone -b $RELEASE $URL_OE
git clone -b $RELEASE $URL_TES
git clone -b $RELEASE $URL_QT5
git clone -b master $URL_ALTERA
pushd meta-altera
git remote add upstream $URL_ALTERA_UPSTREAM
popd
git clone -b $RELEASE $URL_ARM
pushd meta-arm
git remote add upstream $URL_ARM_UPSTREAM
popd
popd
