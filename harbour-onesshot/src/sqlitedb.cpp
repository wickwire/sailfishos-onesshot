#include "sqlitedb.h"
#include <QSqlDatabase>
#include <QSqlQuery>

#include <QDebug>

#include <QCoreApplication>
#include <QStandardPaths>
#include <QDir>
#include <QFile>
#include <QVariantList>


sqliteDB::sqliteDB(QObject *parent) :
    QObject(parent)
{
}

void sqliteDB::createDB(){

    // Find QSLite driver
    db = QSqlDatabase::addDatabase("QSQLITE");

    QString path = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    path.append(QDir::separator()).append("onesshot.db.sqlite");
    path = QDir::toNativeSeparators(path);

    QFile onesshotDB(path);

    // Check if db is accessible - if not, create it
    if(!onesshotDB.exists()){
        qDebug() << "No database found, creating: " << path;
        db.setDatabaseName(path);
        openDB();
        createProfilesTbl();
        createHostsTbl();
        qDebug() << "Close database: " << path;
        db.close();
    }
    else{
        qDebug() << "database already exists: " << path;
        /*dropDB working*/
        //dropDB();

        db.setDatabaseName(path);

        /*addHost working*/
        openDB();
        addHost();

        /*addProfile working*/
        openDB();
        addProfile();

        /*updateProfile working*/
        openDB();
        updateProfile(11, "testProfile333", "echo 'SailfishOS: '`date +'%y-%m-%d %H:%M:%S'` > /tmp/OUTPUT", 222);

        /*deleteHosts working*/
        QVariantList hostList;
        hostList.append(49);
        hostList.append(52);
        hostList.append(53);

        openDB();
        deleteHosts(hostList);

        /*deleteProfiles working*/
        QVariantList profileList;
        profileList.append(45);
        profileList.append(46);
        profileList.append(47);
        profileList.append(48);
        profileList.append(45);
        profileList.append(50);
        profileList.append(51);
        profileList.append(52);
        profileList.append(53);
        profileList.append(54);
        profileList.append(55);

        openDB();
        deleteProfiles(profileList);

    }
    //emit successful creation
}


void sqliteDB::dropDB(){

    db = QSqlDatabase::addDatabase("QSQLITE");

    // Close database
    db.close();

    QString path = QStandardPaths::writableLocation(QStandardPaths::DataLocation);
    path.append(QDir::separator()).append("onesshot.db.sqlite");
    path = QDir::toNativeSeparators(path);
    QFile::remove(path);

    qDebug() << "Database successfully removed: " << path;
    //emit successful drop
}

void sqliteDB::openDB(){
    db.open();
    qDebug() << "Database successfully opened";
}

void sqliteDB::closeDB(){
    db.close();
    qDebug() << "Database successfully closed";
}

void sqliteDB::createProfilesTbl(){
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS oneSSHotProfiles "
              "(profileId INTEGER PRIMARY KEY AUTOINCREMENT, "
              "profileName VARCHAR(30), "
              "profileHostId INTEGER, "
              "profileCommand VARCHAR(100))");
}

void sqliteDB::createHostsTbl(){
    QSqlQuery query;
    query.exec("CREATE TABLE IF NOT EXISTS oneSSHotHosts "
              "(hostId INTEGER PRIMARY KEY AUTOINCREMENT, "
              "hostName varchar(20), "
              "hostAddress varchar(50), "
              "hostPort integer, "
              "hostUser varchar(50))");
}

void sqliteDB::addHost(){
    //insert data into the DB
    //emit success

    QString hostName, hostAddress, hostUser;
    int hostPort;

    hostName="testHost";
    hostAddress="123.456.789.147";
    hostPort=6565;
    hostUser="testUser";

    QSqlQuery query;

    if (db.isOpen())
        {

        qDebug() << "DB is open, ready to insert > addHosts";

        query.prepare("INSERT INTO oneSSHotHosts (hostName, hostAddress, hostPort, hostUser) "
                      "VALUES (?, ?, ?, ?)");
        query.addBindValue(hostName);
        query.addBindValue(hostAddress);
        query.addBindValue(hostPort);
        query.addBindValue(hostUser);
        query.exec();

        closeDB();
        qDebug() << "DB is closed - addHost";
    }
}

void sqliteDB::addProfile(){
    //insert data into the DB
    //emit success

    QString profileName, profileCommand;
    int profileHostId;

    profileName="testProfile";
    /*single quotes are a problem. Need to escape them - using prepare/addBindValue/exec - works */
    profileCommand="echo 'SailfishOS: '`date +'%y-%m-%d %H:%M:%S'` > /tmp/onesshot.tmp";


    profileHostId=3;

    QSqlQuery query;

    if (db.isOpen())
        {

        qDebug() << "DB is open, ready to insert > addProfiles";

        query.prepare("INSERT INTO oneSSHotProfiles (profileName, profileHostId, profileCommand) "
                      "VALUES (?, ?, ?)");
        query.addBindValue(profileName);
        query.addBindValue(profileHostId);
        query.addBindValue(profileCommand);
        query.exec();

        closeDB();
        qDebug() << "DB is closed - addProfile";
    }
}

void sqliteDB::updateProfile(int profileID, QString profileName, QString profileCommand, int profileHostId){
    //emit success

    QSqlQuery query;

    if (db.isOpen())
        {

        qDebug() << "DB is open, ready to insert > updateProfiles";

        query.prepare("UPDATE oneSSHotProfiles SET profileName = ?, profileHostId = ?, profileCommand = ? "
                      "WHERE profileId = ?");
        query.addBindValue(profileName);
        query.addBindValue(profileHostId);
        query.addBindValue(profileCommand);
        query.addBindValue(profileID);
        query.exec();

        closeDB();
        qDebug() << "DB is closed - updateProfile";
    }
}

void sqliteDB::deleteHosts(QVariantList hostList){
    //emit success

    QSqlQuery query;
    int hostIdx;

    QString totalBindValues;

    for(hostIdx=0;hostIdx<hostList.length();hostIdx++){
        if(hostIdx==(hostList.length()-1)){
            totalBindValues+="?";
        }
        else{
            totalBindValues+="?, ";
        }
    }

    if (db.isOpen())
        {

        qDebug() << "DB is open, ready to delete > deleteHosts";

        query.prepare("DELETE FROM oneSSHotHosts WHERE hostId IN ( " + totalBindValues + " )");

        for(hostIdx=0;hostIdx<hostList.length();hostIdx++){

            query.addBindValue(hostList[hostIdx]);

        }

        query.exec();

        closeDB();
        qDebug() << "DB is closed - deleteHosts";
    }
}

void sqliteDB::deleteProfiles(QVariantList profileList){
    //delete profile list from the DB
    //emit success

    QSqlQuery query;
    int profileIdx;

    QString totalBindValues;

    for(profileIdx=0;profileIdx<profileList.length();profileIdx++){
        if(profileIdx==(profileList.length()-1)){
            totalBindValues+="?";
        }
        else{
            totalBindValues+="?, ";
        }
    }

    if (db.isOpen())
        {

        qDebug() << "DB is open, ready to delete > deleteProfiles";

        for(profileIdx=0;profileIdx<profileList.length();profileIdx++){

        query.prepare("DELETE FROM oneSSHotProfiles WHERE profileId IN ( " + totalBindValues + " )");

        for(profileIdx=0;profileIdx<profileList.length();profileIdx++){

            query.addBindValue(profileList[profileIdx]);

        }
        query.exec();
        }

        closeDB();
        qDebug() << "DB is closed - deleteProfiles";
    }
}

void sqliteDB::listHosts(){
    //get host list from the DB
    //emit/return the list
}

void sqliteDB::listProfiles(){
    //get profile list from the DB
    //emit/return the results
}

void sqliteDB::listProfiles4host(){
    //get profile list from the DB, for a specific host
    //emit/return the results
}

void sqliteDB::hostCount(){
    //select count hosts
    //emit/return count
}

void sqliteDB::profileCount(){
    //select count profiles
    //emit/return count
}

void sqliteDB::getTheMark(){
    //get profile data
    //emit/return profile data
}

bool sqliteDB::getGenDB(){
    emit finished();
    return true;
}

void sqliteDB::setGenDB(bool gendb){
    qDebug() << "gendb: " << gendb;
    emit finished();
}

bool sqliteDB::getDelDB(){
    emit finished();
    return true;
}

void sqliteDB::setDelDB(bool deldb){
    qDebug() << "deldb: " << deldb;
    emit finished();
}
