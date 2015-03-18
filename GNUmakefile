include $(GNUSTEP_MAKEFILES)/common.make

#
# Application
#

VERSION = 0.1
PACKAGE_NAME = Calendar
APP_NAME = Calendar
Calendar_APPLICATION_ICON = 

#
# Resource files
#

Calendar_LANGUAGES = English

#info.plist??

Calendar_RESOURCE_FILES = \
        Calendar-Info.plist \

Calendar_LOCALIZED_RESOURCE_FILES = \
	MainMenu.gorm
	
	
#
# Class files
#

Calendar_OBJC_FILES = \
	AppDelegate.m \
	main.m

ADDITIONAL_OBJCFLAGS += -std=c99 -Wno-import -g -fobjc-arc

include $(GNUSTEP_MAKEFILES)/application.make