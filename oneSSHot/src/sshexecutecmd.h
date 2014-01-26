#ifndef SSHEXECUTECMD_H
#define SSHEXECUTECMD_H

#include <QObject>
#include <QDebug>

class sshExecuteCmd : public QObject
{
    Q_OBJECT
public:
    explicit sshExecuteCmd(QObject *parent = 0);

signals:

public slots:
    void executeSSH();

};

#endif // SSHEXECUTECMD_H
