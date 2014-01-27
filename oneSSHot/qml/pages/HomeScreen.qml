import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.LocalStorage 2.0


Page {
    id: page

    property var db: null

    function dropDB() {

        if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE oneSSHotProfiles;');
                tx.executeSql('DROP TABLE oneSSHotHosts;');
            }
        )
    }

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Add New Profile"
                onClicked: pageStack.push("ProfileCreate.qml")
            }
            MenuItem {
                text: "Remove Profiles"
                onClicked: pageStack.push("ProfileDelete.qml")
            }
            MenuItem {
                text: "Clear DB"
                onClicked: {
                    dropDB()
                    var dialog = pageStack.push("DropDB.qml")
                }
            }
            MenuItem {
                text: "About"
                onClicked: pageStack.push("AboutPage.qml")
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

                        //debug only: drop table on start up
                        //tx.executeSql('DROP TABLE oneSSHot;');

                        // Create the database if it doesn't already exist
                        //tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHot( profileName TEXT, profileHost TEXT, profilePort TEXT,profileUser TEXT,profilePass TEXT, profileCommand TEXT);');
                        tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHotProfiles( profileName TEXT, profileHostId INT, profileHost TEXT, profileCommand TEXT);');
                        tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHotHosts( hostName TEXT, hostPort TEXT, hostUser TEXT);');


                        // Show all added profiles

                        rs = tx.executeSql('SELECT * FROM oneSSHotProfiles;');

                        for(var i = 0; i < rs.rows.length; i++) {
                            profileModel.append({"name":rs.rows.item(i).profileName,"hostId":rs.rows.item(i).profileHostId,"host":rs.rows.item(i).profileHost,"command":rs.rows.item(i).profileCommand})
                            console.log('HomeScreen: '+rs.rows.item(i).profileName+'|'+rs.rows.item(i).profileHostId+'|'+rs.rows.item(i).profileHost+'|'+rs.rows.item(i).profileCommand);
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
                onClicked: {
                    console.log("checking: " + username + host + port + command);
                    //sshCmd.executeSSH("wickwire", "192.168.55.100", "22", "echo `date +'%Y-%m-%d %H:%M:%S'` > /home/wickwire/cenas.txt")
                    sshCmd.executeSSH(username, host, port, command)
                    console.log("Clicked " + name)
                }

                onPressAndHold: {
                    console.log("HomeScreen Long Press: " + name + "|" + hostId + "|" + host + "|" + command);

                    var selectedProfile = {
                        "activeProfile" : name,
                        "activeHostId" : hostId,
                        "activeHost" : host,
                        "activeCommand" : command
                    };

                    //pageStack.push("ProfileUpdate.qml")
                    pageStack.push("ProfileUpdate.qml",selectedProfile)
                }
            }
            VerticalScrollDecorator {}
        }

    }
}


