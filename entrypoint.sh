#!/bin/bash

cd ${FIRMWARE_DIR} &&
HEADLESS=1 NO_PXH=1 make px4_sitl_default gz_x500
