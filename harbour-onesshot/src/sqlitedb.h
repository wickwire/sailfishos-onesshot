#ifndef SQLITEDB_H
#define SQLITEDB_H

#include <QObject>
#include <QSqlDatabase>

class sqliteDB : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool genDB READ getDB WRITE setDB NOTIFY DBupdated)
public:
    explicit sqliteDB(QObject *parent = 0);

signals:

public slots:
    bool createDB();

};

#endif // SQLITEDB_H
