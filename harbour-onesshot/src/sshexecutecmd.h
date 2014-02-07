#ifndef SSHEXECUTECMD_H
#define SSHEXECUTECMD_H

#include <QObject>
#include <QDebug>

class sshExecuteCmd : public QObject
{
    Q_PROPERTY(QString pubKey READ getPubKey NOTIFY pubKeyUpdated)
    Q_PROPERTY(QString pubKeyURL READ getPubKeyURL NOTIFY pubKeyURLUpdated)

    Q_OBJECT
public:
    explicit sshExecuteCmd(QObject *parent = 0);
    QString cplusplus_pubKey;
    QString cplusplus_pubKeyURL;
    QString getPubKey();
    QString getPubKeyURL();
    QString data_dir;

signals:
    QVariant pubKeyUpdated(QVariant sshkey);
    QVariant pubKeyURLUpdated(QVariant sshkeyURL);

    void finished();

public slots:
    void executeSSH(QString qmlusername, QString qmladdress, QString qmlport, QString qmlcommand);
    void genKey();
    QString readKey();
    void publishPubKey(QString keyString);
};

#endif // SSHEXECUTECMD_H
