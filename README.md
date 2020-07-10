# yocto_manifest
Helper script to setup a TES Yocto flow.

## setup_repos.sh
Downloads all required repositories.

## setup_build.sh [TARGET]
Sets up a build directory including all Yocto config files to enable building TES Yocto images.
A TARGET parameter defining the target is required:
* a10 - Arria 10
* s10 - Stratix 10

The script will create a folder "build_[TARGET]".

## Source Yocto build environment

	. ./poky/oe-init-build-env build_[TARGET] $BUILD_DIR

## TES only: Update SVN credentials

Update SVN credentials in ./conf/svn.inc

## Build Yocto artifacts

	bitbake virtual/bootloader

	bitbake tes-davenx-evalkit-image

	bitbake tes-davenx-evalkit-image -c populate_sdk

## Generate SD card image

* Stratix 10 SoCDK:
  * 		wic create sdimage-tes-stratix10-socdk -e tes-davenx-evalkit-image
* Arria 10 SoCDK:
  * 		wic create sdimage-tes-stratix10-socdk -e tes-davenx-evalkit-image
* Arria 10 Dreamchip SoM:
  * 		wic create sdimage-tes-stratix10-socdk -e tes-davenx-evalkit-image
