LOG_STEP_IN "- Adding Custom common kernel by @Edgars-cirulis"

local PDR
PDR="$(pwd)"
KERNEL_URL="https://github.com/samsung-sm8550/kernel_samsung_sm8550-common/releases/download/5.15.189/common-5.15.189-manual-ksunext.zip"
BOOT_EDITOR_URL="https://github.com/cfig/Android_boot_image_editor/releases/download/v15_r1/boot_editor_v15_r1.zip"
DOWNLOAD_FILE "$KERNEL_URL" "$WORK_DIR/kernel.zip"
DOWNLOAD_FILE "$BOOT_EDITOR_URL" "$WORK_DIR/kernel/editor.zip"
unzip -pq "$WORK_DIR/kernel.zip" Image.gz >"$WORK_DIR/kernel/Image.gz"
cd $WORK_DIR/kernel/
gzip -d Image.gz
unzip -q "$WORK_DIR/kernel/editor.zip" -d "$WORK_DIR/kernel/editor"
mv "$WORK_DIR/kernel/editor/boot_editor_v15_r1" "$WORK_DIR/kernel/booteditor"
rm -r "$WORK_DIR/kernel/editor"
rm "$WORK_DIR/kernel/editor.zip"
rm "$WORK_DIR/kernel.zip"
mv "$WORK_DIR/kernel/boot.img" "$WORK_DIR/kernel/booteditor/"
cd "$WORK_DIR/kernel/booteditor/" 
./gradlew unpack
mv ../Image "build/unzip_boot/kernel"
./gradlew pack
mv boot.img.clear ../boot.img
cd ..
rm -r booteditor
cd "$PDR"
