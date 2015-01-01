set -x
set -e

# sassc (3.0.2)
if [ ! -e $CIRCLE_BUILD_DIR/bin/sassc ]; then
  export SASS_BUILD_DIR=$HOME/src/github.com/sass
  mkdir -p $SASS_BUILD_DIR
  cd $SASS_BUILD_DIR

  git clone --recursive https://github.com/sass/libsass.git -b 3.0.2
  git clone https://github.com/sass/sassc.git -b 3.0.2

  cd sassc
  SASS_LIBSASS_PATH=$SASS_BUILD_DIR/libsass make

  cp $SASS_BUILD_DIR/sassc/bin/sassc $CIRCLE_BUILD_DIR/bin/sassc
fi
