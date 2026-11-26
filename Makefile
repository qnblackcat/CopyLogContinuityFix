TARGET = iphone:clang:16.5:16.0
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = pasted

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CopyLogContinuityFix

CopyLogContinuityFix_FILES = Tweak.x
CopyLogContinuityFix_FRAMEWORKS = Foundation
CopyLogContinuityFix_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
