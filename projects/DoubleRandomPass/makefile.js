exports.makefile = {
    name: "DoubleRandomPass",
    type: "tweak",
    archs: new Array("armv7", "arm64"),
    target: "iphone:latest:7.0",
    files: new Array("DoubleRandomPass.xm"),
    frameworks: new Array("UIKit"),
    version: "1.0",
    after_install: "killall -9 SpringBoard"
}
