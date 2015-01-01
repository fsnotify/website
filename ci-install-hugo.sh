set -x
set -e
if [ ! -e $CIRCLE_BUILD_DIR/bin/hugo ]; then
  wget https://github.com/spf13/hugo/releases/download/v0.12/hugo_0.12_linux_amd64.tar.gz
  tar xvzf hugo_0.12_linux_amd64.tar.gz
  cp hugo_0.12_linux_amd64/hugo_0.12_linux_amd64 $CIRCLE_BUILD_DIR/bin/hugo
fi
