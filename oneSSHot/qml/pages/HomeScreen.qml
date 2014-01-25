import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Add New Profile"
                onClicked: pageStack.push(Qt.resolvedUrl("AddProfile.qml"))
            }
            MenuItem {
                text: "Manage Existing Profile"
                onClicked: pageStack.push(Qt.resolvedUrl("ManageProfiles.qml"))
            }
            MenuItem {
                text: "About oneSSHot"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "oneSSHot Main Screen"
            }
            Label {
                x: Theme.paddingLarge
                text: "To hold the profile list"
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeExtraLarge
            }
        }
    }
}


