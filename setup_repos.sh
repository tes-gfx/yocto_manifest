RELEASE=dunfell

git clone -b $RELEASE git://git.yoctoproject.org/poky

mkdir -p downloads
mkdir -p repos
pushd repos
git clone -b $RELEASE git@github.com:openembedded/meta-openembedded.git
git clone -b $RELEASE git@github.com:tes-gfx/meta-tes.git
git clone -b master git@github.com:tes-gfx/meta-altera.git
pushd meta-altera
git remote add upstream git@github.com:kraj/meta-altera
popd
git clone -b $RELEASE git@github.com:tes-gfx/meta-arm
pushd meta-arm
git remote add upstream git://git.yoctoproject.org/meta-arm
popd
popd
