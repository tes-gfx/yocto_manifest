RELEASE=kirkstone

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

clone_or_skip()
{
	local RELEASE=$1
	local URL=$2
	local DIR=$3
	local UPSTREAM=$4
	if [ -d "$3" ]; then
		echo "Skipping $3"
	else
		git clone -b $RELEASE $URL
		if [ ! -z $UPSTREAM ]; then
			pushd $DIR
				git remote add upstream $UPSTREAM
			popd
		fi
	fi
}

clone_or_pull()
{
	local RELEASE=$1
	local URL=$2
	local DIR=$3
	if [ -d "$3" ]; then
		echo "Pull from $2"
		pushd $DIR
		git pull origin
		popd
	else
		echo "Cloning branch $RELEASE from $URL..."
		git clone -b $RELEASE $URL
	fi
}

case $1 in

	ssh)
		echo "Protocol: SSH"
		URL_POKY="git://git.yoctoproject.org/poky"
		URL_OE="git@github.com:openembedded/meta-openembedded.git"
		URL_TES="git@github.com:tes-gfx/meta-tes.git"
		URL_QT5="git@github.com:tes-gfx/meta-qt5.git"
		URL_QT5_UPSTREAM="git@github.com:meta-qt5/meta-qt5.git"
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
		URL_QT5="https://github.com/tes-gfx/meta-qt5.git"
		URL_QT5_UPSTREAM="https://github.com/meta-qt5/meta-qt5.git"
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

clone_or_skip $RELEASE $URL_POKY poky

mkdir -p downloads
mkdir -p repos

pushd repos

clone_or_skip $RELEASE $URL_OE meta-openembedded
clone_or_pull $RELEASE $URL_TES meta-tes
clone_or_pull $RELEASE $URL_QT5 meta-qt5 $URL_QT5_UPSTREAM
clone_or_pull master $URL_ALTERA meta-altera $URL_ALTERA_UPSTREAM
clone_or_pull $RELEASE $URL_ARM meta-arm $URL_ARM_UPSTREAM

popd
