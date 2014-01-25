import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0


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
                text: "Remove Profiles"
                onClicked: pageStack.push(Qt.resolvedUrl("RemoveProfiles.qml"))
            }
            MenuItem {
                text: "About"
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
        }

        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height



        Component.onCompleted: {
            //listProfiles()
            //console.log("rs.rows.length: " + rs.rows.length)

        }

        ListModel{
            id: profileModel

            property var db: null
            property var rs: null

            function listProfiles() {

                if(db !== null) return;

                db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);
                db.transaction(
                    function(tx) {

                        tx.executeSql('DROP TABLE oneSSHot;');

                        // Create the database if it doesn't already exist
                        tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHot( profileName TEXT, profileHost TEXT, profilePort TEXT,profileUser TEXT,profilePass TEXT, profileCommand TEXT);');

                        // Add (another) profile row
                        //tx.executeSql('INSERT INTO oneSSHot VALUES(?, ?, ?, ?, ?, ?);', ['writeEcho', '192.168.55.104', '22', 'wickwire', 'Sp4rt4kusDun3', 'batata']);

                        // Show all added profiles

                        rs = tx.executeSql('SELECT * FROM oneSSHot;');

                        for(var i = 0; i < rs.rows.length; i++) {
                            profileModel.append({"name":rs.rows.item(i).profileName})
                        }

                        if(rs.rows.length === 0){
                            console.log("Profiles are empty")
                            profileModel.clear()
                            profileModel.append({"name":"<Empty Profile List>\n\nSlide down to add a Profile"})
                        }
                    }
                )

            }

            Component.onCompleted: {

                listProfiles()

            }

        }

        SilicaListView {

            id: listView
            model: profileModel
            anchors.fill: parent
            header: PageHeader {
                title: "Profile List"
            }
            delegate: BackgroundItem {
                id: delegate

                Label {
                    x: Theme.paddingLarge
                    text: name
                    anchors.verticalCenter: parent.verticalCenter
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                onClicked: console.log("Clicked " + index)
            }
            VerticalScrollDecorator {}
        }

    }
}


