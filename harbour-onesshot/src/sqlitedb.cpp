#include "sqlitedb.h"
#include <QSqlDatabase>
#include <QDebug>

#include <QCoreApplication>
#include <QStandardPaths>
#include <QDir>
#include <QFile>


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
        db.open();
        qDebug() << "Close database: " << path;
        db.close();
    }
    else{
        qDebug() << "database already exists: " << path;
        dropDB();
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

void sqliteDB::addHost(){
    //insert data into the DB
    //emit success
}

void sqliteDB::deleteHosts(){
    //delete hosts from the DB
    //emit success
}

void sqliteDB::listHosts(){
    //get host list from the DB
    //emit/return the list
}

void sqliteDB::addProfile(){
    //insert data into the DB
    //emit success
}

void sqliteDB::updateProfile(){
    //get data from the DB
    //insert data into the DB
    //emit success
}

void sqliteDB::deleteProfiles(){
    //delete profile list from the DB
    //emit success
}

void sqliteDB::listProfiles(){
    //get profile list from the DB
    //emit/return the results
}

void sqliteDB::listProfiles4host(){
    //get profile list from the DB, for a specific host
    //emit/return the results
}





bool sqliteDB::getGenDB(){

    emit finished();
    return true;
}

void sqliteDB::setGenDB(bool gendb){

    emit finished();
}

bool sqliteDB::getDelDB(){

    emit finished();
    return true;

}

void sqliteDB::setDelDB(bool deldb){

    emit finished();

}
