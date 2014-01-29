import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item{

    property var db: null
    property var rs: null

    function updateProfile() {

        if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                rs = tx.executeSql('SELECT profileName FROM oneSSHotProfiles WHERE profileName = "cenas";');

                tx.executeSql('UPDATE oneSSHotProfiles SET profileName="' + profileName + '", profileHostId=' + profileHostId + ', profileHost="' + profileHost + '", profileCommand="' + profileCommand + '" WHERE profileName="' + activeProfile + '";');
            }
        )
    }

    function saveProfile() {

        if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                // Add (another) profile row
                tx.executeSql('INSERT INTO oneSSHotProfiles VALUES(?, ?, ?, ?);', [profileName, profileHostId, profileHost, profileCommand]);

                rs = tx.executeSql('SELECT * FROM oneSSHotProfiles;');

                for(var i = 0; i < rs.rows.length; i++) {
                    console.log(rs.rows.item(i).profileName
                                + "|" + rs.rows.item(i).profileHostId
                                + "|" + rs.rows.item(i).profileHost
                                //+ "|" + rs.rows.item(i).profilePort
                                //+ "|" + rs.rows.item(i).profileUser
                                //+ "|" + rs.rows.item(i).profilePass
                                + "|" + rs.rows.item(i).profileCommand
                    )
                }


            }
        )
    }

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

}
