/****************************************************************************
** Meta object code from reading C++ file 'sshexecutecmd.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.1.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../harbour-onesshot/src/sshexecutecmd.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'sshexecutecmd.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.1.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_sshExecuteCmd_t {
    QByteArrayData data[18];
    char stringdata[182];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    offsetof(qt_meta_stringdata_sshExecuteCmd_t, stringdata) + ofs \
        - idx * sizeof(QByteArrayData) \
    )
static const qt_meta_stringdata_sshExecuteCmd_t qt_meta_stringdata_sshExecuteCmd = {
    {
QT_MOC_LITERAL(0, 0, 13),
QT_MOC_LITERAL(1, 14, 13),
QT_MOC_LITERAL(2, 28, 0),
QT_MOC_LITERAL(3, 29, 6),
QT_MOC_LITERAL(4, 36, 16),
QT_MOC_LITERAL(5, 53, 9),
QT_MOC_LITERAL(6, 63, 8),
QT_MOC_LITERAL(7, 72, 10),
QT_MOC_LITERAL(8, 83, 11),
QT_MOC_LITERAL(9, 95, 10),
QT_MOC_LITERAL(10, 106, 7),
QT_MOC_LITERAL(11, 114, 10),
QT_MOC_LITERAL(12, 125, 6),
QT_MOC_LITERAL(13, 132, 7),
QT_MOC_LITERAL(14, 140, 13),
QT_MOC_LITERAL(15, 154, 9),
QT_MOC_LITERAL(16, 164, 6),
QT_MOC_LITERAL(17, 171, 9)
    },
    "sshExecuteCmd\0pubKeyUpdated\0\0sshkey\0"
    "pubKeyURLUpdated\0sshkeyURL\0finished\0"
    "executeSSH\0qmlusername\0qmladdress\0"
    "qmlport\0qmlcommand\0genKey\0readKey\0"
    "publishPubKey\0keyString\0pubKey\0pubKeyURL\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_sshExecuteCmd[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       7,   14, // methods
       2,   70, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       3,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   49,    2, 0x05,
       4,    1,   52,    2, 0x05,
       6,    0,   55,    2, 0x05,

 // slots: name, argc, parameters, tag, flags
       7,    4,   56,    2, 0x0a,
      12,    0,   65,    2, 0x0a,
      13,    0,   66,    2, 0x0a,
      14,    1,   67,    2, 0x0a,

 // signals: parameters
    QMetaType::QVariant, QMetaType::QVariant,    3,
    QMetaType::QVariant, QMetaType::QVariant,    5,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,    8,    9,   10,   11,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   15,

 // properties: name, type, flags
      16, QMetaType::QString, 0x00495001,
      17, QMetaType::QString, 0x00495001,

 // properties: notify_signal_id
       0,
       1,

       0        // eod
};

void sshExecuteCmd::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        sshExecuteCmd *_t = static_cast<sshExecuteCmd *>(_o);
        switch (_id) {
        case 0: { QVariant _r = _t->pubKeyUpdated((*reinterpret_cast< QVariant(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 1: { QVariant _r = _t->pubKeyURLUpdated((*reinterpret_cast< QVariant(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 2: _t->finished(); break;
        case 3: _t->executeSSH((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 4: _t->genKey(); break;
        case 5: { QString _r = _t->readKey();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 6: _t->publishPubKey((*reinterpret_cast< QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef QVariant (sshExecuteCmd::*_t)(QVariant );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&sshExecuteCmd::pubKeyUpdated)) {
                *result = 0;
            }
        }
        {
            typedef QVariant (sshExecuteCmd::*_t)(QVariant );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&sshExecuteCmd::pubKeyURLUpdated)) {
                *result = 1;
            }
        }
        {
            typedef void (sshExecuteCmd::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&sshExecuteCmd::finished)) {
                *result = 2;
            }
        }
    }
}

const QMetaObject sshExecuteCmd::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_sshExecuteCmd.data,
      qt_meta_data_sshExecuteCmd,  qt_static_metacall, 0, 0}
};


const QMetaObject *sshExecuteCmd::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *sshExecuteCmd::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_sshExecuteCmd.stringdata))
        return static_cast<void*>(const_cast< sshExecuteCmd*>(this));
    return QObject::qt_metacast(_clname);
}

int sshExecuteCmd::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 7)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 7;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 7)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 7;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = getPubKey(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getPubKeyURL(); break;
        }
        _id -= 2;
    } else if (_c == QMetaObject::WriteProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 2;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 2;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 2)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 2;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
QVariant sshExecuteCmd::pubKeyUpdated(QVariant _t1)
{
    QVariant _t0 = QVariant();
    void *_a[] = { const_cast<void*>(reinterpret_cast<const void*>(&_t0)), const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
    return _t0;
}

// SIGNAL 1
QVariant sshExecuteCmd::pubKeyURLUpdated(QVariant _t1)
{
    QVariant _t0 = QVariant();
    void *_a[] = { const_cast<void*>(reinterpret_cast<const void*>(&_t0)), const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
    return _t0;
}

// SIGNAL 2
void sshExecuteCmd::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 2, 0);
}
QT_END_MOC_NAMESPACE
