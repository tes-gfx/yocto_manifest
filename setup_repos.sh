RELEASE=dunfell

git clone -b $RELEASE git://git.yoctoproject.org/poky

mkdir -p repos
pushd repos
git clone -b $RELEASE git@github.com:openembedded/meta-openembedded.git
git clone -b $RELEASE git@github.com:c-thaler/meta-tes.git
git clone -b $RELEASE git@github.com:c-thaler/meta-qt5.git
git clone -b $RELEASE git@github.com:c-thaler/meta-altera.git
pushd meta-altera
git remote add upstream git@github.com:kraj/meta-altera
popd
git clone -b $RELEASE git@github.com:c-thaler/meta-arm
pushd meta-arm
git remote add upstream git://git.yoctoproject.org/meta-arm
popd
popd
