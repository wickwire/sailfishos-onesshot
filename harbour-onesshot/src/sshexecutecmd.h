#ifndef SSHEXECUTECMD_H
#define SSHEXECUTECMD_H

#include <QObject>
#include <QDebug>

class sshExecuteCmd : public QObject
{
    Q_OBJECT
public:
    explicit sshExecuteCmd(QObject *parent = 0);
    //QString qmlhost, qmlport, qmluser, qmlcommand;

signals:

public slots:
    void executeSSH(QString qmlusername, QString qmlhost, QString qmlport, QString qmlcommand);
    void pushPubKey(QString qmlhost, int qmlport, QString qmlusername);
};

#endif // SSHEXECUTECMD_H
