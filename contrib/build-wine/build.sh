#!/bin/sh
# Lucky number
export PYTHONHASHSEED=22

here=$(dirname "$0")

echo "Clearing $here/build and $here/dist..."
rm $here/build/* -rf
rm $here/dist/* -rf

$here/prepare-wine.sh && \
$here/prepare-pyinstaller.sh && \
$here/prepare-hw.sh || exit 1

echo "Resetting modification time in C:\Python..."
# (Because of some bugs in pyinstaller)
pushd /opt/wine64/drive_c/python*
find -type f -exec touch -d '2000-11-11 11:11:11' {} +
popd
ls -l /opt/wine64/drive_c/python*

$here/build-electrum-git.sh && \
echo "Done."
