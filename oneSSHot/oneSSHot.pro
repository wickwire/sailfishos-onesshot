# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = oneSSHot

CONFIG += sailfishapp

SOURCES += src/oneSSHot.cpp

OTHER_FILES += qml/oneSSHot.qml \
    qml/cover/CoverPage.qml \
    rpm/oneSSHot.spec \
    rpm/oneSSHot.yaml \
    oneSSHot.desktop \
    qml/pages/HomeScreen.qml \
    qml/pages/AddProfile.qml \
    qml/pages/ManageProfiles.qml \
    qml/pages/AboutPage.qml \
    qml/pages/RemoveProfiles.qml \
    qml/pages/DropDB.qml

