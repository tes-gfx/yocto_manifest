# yocto_manifest
Helper script to setup a TES Yocto flow.

## setup_repos.sh
Downloads all required repositories.
A protocol parameter defining the protocol for GIT is required:
* ssh   - Use SSH protocol (a private key file might be required)
* https - Use HTTPS protocol

## setup_build.sh [TARGET]
Sets up a build directory including all Yocto config files to enable building TES Yocto images.
A TARGET parameter defining the target is required:
* c5  - Cyclone 5
* a10 - Arria 10
* s10 - Stratix 10

The script will create a folder "build_[TARGET]".

## Source Yocto build environment

	. ./poky/oe-init-build-env build_[TARGET] $BUILD_DIR

## TES internal only: Update SVN credentials

Update SVN credentials in ./conf/svn.inc

Make sure to append "tesintern" to OVERRIDES variable in ./conf/local.conf.
This will enable source fetching from internal SVN.

## Build Yocto artifacts

	bitbake virtual/bootloader

	bitbake [IMAGE_NAME]

	bitbake [IMAGE-NAME] -c populate_sdk

## Generate SD card image

* Stratix 10 SoCDK:
  * 		wic create sdimage-tes-stratix10-socdk -e tes-davenx-evalkit-image
* Arria 10 SoCDK:
  * 		wic create sdimage-tes-arria10-socdk -e tes-davenx-evalkit-image
* Arria 10 Dreamchip SoM:
  * 		wic create sdimage-tes-dreamchip-arria10som -e tes-davenx-evalkit-image
* Cyclone 5 DE0 Nano SoC:
  * 		wic create sdimage-tes-cyclone5-de0-nano -e tes-ip-evalkit-image
* Cyclone 5 DE0 Nano SoC w/ GPIO_0 LCD display:
  * 		wic create sdimage-tes-cyclone5-de0-nano -e tes-dave2d-lcd-image
