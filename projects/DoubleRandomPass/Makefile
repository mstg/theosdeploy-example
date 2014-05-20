ARCHS = armv7 arm64
TARGET = iphone:latest:7.0

include theos/makefiles/common.mk

TWEAK_NAME = DoubleRandomPass
DoubleRandomPass_FILES = DoubleRandomPass.xm
DoubleRandomPass_FRAMEWORKS = UIKit

THEOS_PACKAGE_BASE_VERSION = 1.0
_THEOS_INTERNAL_PACKAGE_VERSION = 1.0

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
