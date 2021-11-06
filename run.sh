#!/bin/bash

rm -rf build
mkdir build

clang -x c -target arm64-apple-ios13 -Os \
-isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk \
-emit-llvm \
-c example.c -o build/example.o

llc \
-march=arm64 \
-enable-machine-outliner=always -machine-outliner-reruns=1 \
--simplify-mir \
-stop-before=machine-outliner \
build/example.o \
-o build/example.mir

patch -p1 < diff.patch

llc \
-march=arm64 \
-run-pass=machine-outliner -machine-outliner-reruns=1 \
--simplify-mir \
-verify-machineinstrs \
build/example.mir \
-o build/example.outlined.mir

cat build/example.outlined.mir | tail -n +165 | head -n 10
