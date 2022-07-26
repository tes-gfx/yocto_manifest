# yocto_manifest
Helper script to setup a TES Yocto flow.

## setup_repos.sh
Downloads all required repositories.
A protocol parameter defining the protocol for GIT is required:
* ssh   - Use SSH protocol (a private key file might be required)
* https - Use HTTPS protocol
A dir parameter is required, pointing to the directory where the repos will be cloned to.

## setup_build.sh [TARGET]
Sets up a build directory including all Yocto config files to enable building TES Yocto images.
A TARGET parameter defining the target is required:
* c5  - Cyclone 5
* a10 - Arria 10
* s10 - Stratix 10
A dir parameter is required, pointing to the directory where the repos have been cloned to.

The script will create a folder "build_[TARGET]".

## Source Yocto build environment
```
	. ./poky/oe-init-build-env build_[TARGET] $BUILD_DIR
```

## TES internal only: Update SVN credentials

Update SVN credentials in ./conf/svn.inc

Make sure to append "tesintern" to OVERRIDES variable in `./conf/local.conf`.
This will enable source fetching from internal SVN.

## Overrides

### de10

When building for the DE10-Nano board, please make sure to append `de10` to `OVERRIDES` variable in `./conf/local.conf`.
This is required to select the matching bootloader for the DE10 board.

## Build Yocto artifacts

	bitbake virtual/bootloader

	bitbake [IMAGE_NAME]

	bitbake [IMAGE-NAME] -c populate_sdk

## Available SD card images

* tes-davenx-evalkit-image - TES DaveNX EvalKit
* tes-ip-evalkit-image - TES IP EvalKit (DaveHD, Dave2D, CDC, Warping Engine)
* tes-dave2d-lcd-image - TES Dave2D EvalKit with LCD panel support for DE10-Nano board

## SD card images

The SD card images can be found in `tmp/deploy/images/[TARGET]` as `*.wic` files.
