#!/bin/bash

rm -rf build
mkdir build

clang -x objective-c -target arm64-apple-ios10.0 -Os \
-fobjc-arc -fobjc-weak \
-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS15.0.sdk \
-emit-llvm \
-c src/RCTImageUtils.m -o build/RCTImageUtils.o

opt --Os -objc-arc-contract build/RCTImageUtils.o -o build/RCTImageUtils.o

llc \
-march=arm64 \
-enable-machine-outliner=always -machine-outliner-reruns=1 \
--simplify-mir \
-stop-before=machine-outliner \
build/RCTImageUtils.o \
-o build/RCTImageUtils.mir

patch -p1 < diff.patch

llc \
-march=arm64 \
-run-pass=machine-outliner -machine-outliner-reruns=1 \
--simplify-mir \
-verify-machineinstrs \
build/RCTImageUtils.mir \
-o build/RCTImageUtils.outlined.mir

cat build/RCTImageUtils.outlined.mir  | tail -n +315 | head -n 10
