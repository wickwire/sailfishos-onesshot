import QtQuick 2.0
import QtQuick.LocalStorage 2.0

Item{

    property var db: null
    property var rs: null

    function hostCount(){
        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                rs = tx.executeSql('SELECT hostId FROM oneSSHotHosts;');

                countHosts=rs.rows.length

                console.log("DBFunction: hostCount: " + countHosts)
            }
        )
    }

    function profileCount(){
        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                rs = tx.executeSql('SELECT profileId FROM oneSSHotProfiles;');

                countProfiles=rs.rows.length

                console.log("DBFunction: profileCount: " + countProfiles)
            }
        )
    }

    function getTheMark(hostId,profileId){
        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                rs = tx.executeSql('SELECT hosts.hostUser, hosts.hostName, hosts.hostAddress, hosts.hostPort, profiles.profileCommand FROM oneSSHotHosts hosts, oneSSHotProfiles profiles WHERE profiles.profileHostId = hosts.hostId AND hosts.hostId = ' + hostId + ' and profiles.profileId = ' + profileId);

                for(var i = 0; i < rs.rows.length; i++) {
                    console.log("getTheMark: " + rs.rows.item(i).hostUser
                                + "|" + rs.rows.item(i).hostName
                                + "|" + rs.rows.item(i).hostAddress
                                + "|" + rs.rows.item(i).hostPort
                                + "|" + rs.rows.item(i).profileCommand
                    )
                }

                sshUser=rs.rows.item(0).hostUser
                sshHost=rs.rows.item(0).hostName
                sshAddress=rs.rows.item(0).hostAddress
                sshPort=rs.rows.item(0).hostPort
                sshCommand=rs.rows.item(0).profileCommand
            }
        )
    }

    function addHost(){

        //if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                // Add (another) profile row
                tx.executeSql('INSERT INTO oneSSHotHosts (hostName, hostAddress, hostPort, hostUser) VALUES(?, ?, ?, ?);', [hostName, hostAddress, hostPort, hostUser]);

                rs = tx.executeSql('SELECT * FROM oneSSHotHosts;');

                for(var i = 0; i < rs.rows.length; i++) {
                    console.log("addHost: " + rs.rows.item(i).hostId
                                + "|" + rs.rows.item(i).hostName
                                + "|" + rs.rows.item(i).hostAddress
                                + "|" + rs.rows.item(i).hostPort
                                + "|" + rs.rows.item(i).hostUser
                    )
                }
            }
        )
    }

    function deleteHosts(){

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {
                tx.executeSql('DELETE FROM oneSSHotHosts WHERE hostId IN ('+ hostsArray +');');
            }
        )
    }

    function listHosts() {

        //if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                // Show all added hosts

                rs = tx.executeSql('SELECT * FROM oneSSHotHosts;');

                for(var i = 0; i < rs.rows.length; i++) {
                    hostModel.append({"hostId":rs.rows.item(i).hostId,"name":rs.rows.item(i).hostName,"address":rs.rows.item(i).hostAddress,"port":rs.rows.item(i).hostPort,"user":rs.rows.item(i).hostUser})
                    console.log('listHosts: '+rs.rows.item(i).hostId+'|'+rs.rows.item(i).hostName+'|'+rs.rows.item(i).hostAddress+'|'+rs.rows.item(i).hostPort+'|'+rs.rows.item(i).hostUser);
                }

                if(rs.rows.length === 0){
                    console.log("Hosts are empty")
                    hostModel.clear()
                    hostModel.append({"name":"<Empty Host List>\n\nSlide down to add a Host"})
                }
            }
        )

    }

    function listProfiles() {

        //if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                // Create the database if it doesn't already exist
                tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHotProfiles(profileId INTEGER PRIMARY KEY AUTOINCREMENT, profileName TEXT, profileHostId INT, profileCommand TEXT);');
                tx.executeSql('CREATE TABLE IF NOT EXISTS oneSSHotHosts(hostId INTEGER PRIMARY KEY AUTOINCREMENT, hostName TEXT, hostAddress TEXT, hostPort INT, hostUser TEXT);');

                // Show all added profiles

                rs = tx.executeSql('SELECT * FROM oneSSHotProfiles;');

                for(var i = 0; i < rs.rows.length; i++) {
                    profileModel.append({"profileId":rs.rows.item(i).profileId,"name":rs.rows.item(i).profileName,"hostId":rs.rows.item(i).profileHostId,"command":rs.rows.item(i).profileCommand})
                    console.log('listProfiles: '+rs.rows.item(i).profileId+'|'+rs.rows.item(i).profileName+'|'+rs.rows.item(i).profileHostId+'|'+rs.rows.item(i).profileCommand);
                }

                if(rs.rows.length === 0){
                    console.log("Profiles are empty")
                    profileModel.clear()
                    profileModel.append({"name":"<Empty Profile List>\n\nSlide down to add a Profile"})
                }
            }
        )

    }

    function updateProfile() {

        //if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {
                tx.executeSql('UPDATE oneSSHotProfiles SET profileName="' + profileName + '", profileHostId=' + profileHostId + ', profileCommand="' + profileCommand + '" WHERE profileId="' + activeProfileId + '";');

                rs = tx.executeSql('SELECT * FROM oneSSHotProfiles;');

                for(var i = 0; i < rs.rows.length; i++) {
                    console.log("updateProfile: " + rs.rows.item(i).profileId
                                + "|" + rs.rows.item(i).profileName
                                + "|" + rs.rows.item(i).profileHostId
                                + "|" + rs.rows.item(i).profileCommand
                    )
                }
            }
        )
    }

    function saveProfile() {

        //if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {

                // Add (another) profile row
                tx.executeSql('INSERT INTO oneSSHotProfiles (profileName, profileHostId, profileCommand) VALUES(?, ?, ?);', [profileName, profileHostId, profileCommand]);

                rs = tx.executeSql('SELECT * FROM oneSSHotProfiles;');

                for(var i = 0; i < rs.rows.length; i++) {
                    console.log("saveProfile: " + rs.rows.item(i).profileId
                                + "|" + rs.rows.item(i).profileName
                                + "|" + rs.rows.item(i).profileHostId
                                + "|" + rs.rows.item(i).profileCommand
                    )
                }
            }
        )
    }

    function deleteProfiles(){

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {
                tx.executeSql('DELETE FROM oneSSHotProfiles WHERE profileId IN ('+ profilesArray +');');
            }
        )
    }

    function dropDB() {

        //if(db !== null) return;

        db = LocalStorage.openDatabaseSync("QQmlOneSSHotDB", "1.0", "QML OneSSHot Profiles DB", 1000000);

        db.transaction(
            function(tx) {
                tx.executeSql('DROP TABLE oneSSHotProfiles;');
                tx.executeSql('DROP TABLE oneSSHotHosts;');
            }
        )
    }
}
