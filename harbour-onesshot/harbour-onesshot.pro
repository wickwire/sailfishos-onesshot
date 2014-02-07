# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-onesshot

CONFIG += sailfishapp

SOURCES += src/oneSSHot.cpp \
    src/sshexecutecmd.cpp

OTHER_FILES += qml/oneSSHot.qml \
    qml/cover/CoverPage.qml \
    rpm/oneSSHot.spec \
    rpm/oneSSHot.yaml \
    oneSSHot.desktop \
    qml/pages/HomeScreen.qml \
    qml/pages/AboutPage.qml \
    qml/pages/DropDB.qml \
    qml/pages/ProfileDelete.qml \
    qml/pages/ProfileCreate.qml \
    qml/pages/ProfileUpdate.qml \
    qml/pages/HostCreate.qml \
    qml/pages/HostDelete.qml \
    qml/pages/DBFunctions.qml \
    qml/pages/GetSSHKey.qml \
    harbour-onesshot.png

HEADERS += \
    src/sshexecutecmd.h

