jdeps_modules=$(jdeps --module-path $JAVAFX_HOME --print-module-deps --ignore-missing-deps app/target/lib/scenebuilder-$VERSION-all.jar)
JAVAFX_MODULES=javafx.fxml,javafx.media,javafx.swing,javafx.web

download_url="https://cdn.azul.com/zulu/bin/zulu16.30.19-ca-jdk16.0.1-macosx_aarch64.tar.gz"
wget -O $RUNNER_TEMP/java_package.tar.gz $download_url
tar -xvf $RUNNER_TEMP/java_package.tar.gz -C $RUNNER_TEMP/

$JAVA_HOME/bin/jlink \
--module-path -C $RUNNER_TEMP/zulu16.30.19-ca-jdk16.0.1-macosx_aarch64/jmods/:$JAVAFX_HOME \
--add-modules $jdeps_modules,$JAVAFX_MODULES \
--output app/target/runtime \
--strip-debug --compress 2 --no-header-files --no-man-pages

$JPACKAGE_HOME/bin/jpackage \
--app-version $VERSION \
--input app/target/lib \
--license-file LICENSE.txt \
--main-jar scenebuilder-$VERSION-all.jar \
--main-class $MAIN_CLASS \
--name SceneBuilder \
--description "Scene Builder" \
--vendor Gluon \
--verbose \
--runtime-image app/target/runtime \
--dest $INSTALL_DIR \
"$@"
