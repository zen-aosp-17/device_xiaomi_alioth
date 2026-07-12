#!/bin/bash

# Decode Xiaomi camera license
base64 -d device/xiaomi/alioth/configs/camera/secret > device/xiaomi/alioth/configs/camera/st_license.lic

# Clone kernel_xiaomi_sm8250
if [ ! -d "kernel/xiaomi/sm8250" ]; then
    git clone https://github.com/zen-aosp-17/kernel_xiaomi_sm8250.git kernel/xiaomi/sm8250 --depth=1
fi

cd kernel/xiaomi/sm8250
git submodule init
git submodule update
cd ../../../

# Clone device_xiaomi_sm8250-common
if [ ! -d "device/xiaomi/sm8250-common" ]; then
    git clone https://github.com/zen-aosp-17/device_xiaomi_sm8250-common.git device/xiaomi/sm8250-common -b test
fi

# Clone vendor_xiaomi_alioth
if [ ! -d "vendor/xiaomi/alioth" ]; then
    git clone https://github.com/zen-aosp-17/vendor_xiaomi_alioth.git vendor/xiaomi/alioth -b aosp-17
fi

# Clone vendor_xiaomi_sm8250-common
if [ ! -d "vendor/xiaomi/sm8250-common" ]; then
    git clone https://github.com/zen-aosp-17/vendor_xiaomi_sm8250-common.git vendor/xiaomi/sm8250-common -b aosp-17
fi

# Clone hardware_xiaomi
if [ ! -d "hardware/xiaomi" ]; then
    git clone https://github.com/zen-aosp-17/hardware_xiaomi.git hardware/xiaomi -b aosp-16
fi

# Clone hardware_dolby
if [ ! -d "hardware/dolby" ]; then
    git clone https://github.com/custom-crdroid/hardware_dolby.git hardware/dolby --depth 1
fi

# Clone device_xiaomi_camera
if [ ! -d "device/xiaomi/camera" ]; then
    git clone https://github.com/Sanjis-Android-Playground/device_xiaomi_camera.git device/xiaomi/camera -b aosp-16
fi

# Clone vendor_xiaomi_camera
if [ ! -d "vendor/xiaomi/camera" ]; then
    git clone https://gitlab.com/johnmart19/vendor_xiaomi_camera vendor/xiaomi/camera -b aosp-16 --depth 1
fi

# Clone packages_apps_GameBar
if [ ! -d "packages/apps/GameBar" ]; then
    git clone https://github.com/Sanjis-Android-Playground/packages_apps_GameBar.git packages/apps/GameBar/
fi

# Apply Binder threadpool patch
if [ -d "system/libhwbinder" ]; then
    cd system/libhwbinder
    if ! git log -n 50 | grep -q "Binder threadpool"; then
        git fetch https://github.com/custom-crdroid/system_libhwbinder.git d9d46e78cec0d09498fd5890eed9f7195baed0fd 2>/dev/null || true
        git cherry-pick d9d46e78cec0d09498fd5890eed9f7195baed0fd 2>/dev/null || true
    fi
    cd - > /dev/null
fi