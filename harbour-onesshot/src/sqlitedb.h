#ifndef SQLITEDB_H
#define SQLITEDB_H

#include <QObject>
#include <QSqlDatabase>

class sqliteDB : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool genDB READ getGenDB WRITE setGenDB NOTIFY GenDBupdated)
    Q_PROPERTY(bool delDB READ getDelDB WRITE setDelDB NOTIFY DelDBupdated)
public:
    explicit sqliteDB(QObject *parent = 0);
    bool getGenDB();
    void setGenDB(bool);
    bool getDelDB();
    void setDelDB(bool);

signals:
    bool GenDBupdated();
    bool DelDBupdated();
    void finished();

public slots:
    void createDB();
    void openDB();
    void closeDB();
    void dropDB();
    void createProfilesTbl();
    void createHostsTbl();
    void hostCount();
    void profileCount();
    void getTheMark();
    void addHost();
    void deleteHosts();
    void listHosts();
    void addProfile();
    void updateProfile(int profileID);
    void deleteProfiles();
    void listProfiles();
    void listProfiles4host();

private:
    QSqlDatabase db;
};

#endif // SQLITEDB_H
