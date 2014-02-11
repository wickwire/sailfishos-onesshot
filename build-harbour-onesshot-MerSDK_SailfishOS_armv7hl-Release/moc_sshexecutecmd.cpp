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
    QByteArrayData data[26];
    char stringdata[304];
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
QT_MOC_LITERAL(6, 63, 19),
QT_MOC_LITERAL(7, 83, 20),
QT_MOC_LITERAL(8, 104, 8),
QT_MOC_LITERAL(9, 113, 10),
QT_MOC_LITERAL(10, 124, 11),
QT_MOC_LITERAL(11, 136, 10),
QT_MOC_LITERAL(12, 147, 7),
QT_MOC_LITERAL(13, 155, 10),
QT_MOC_LITERAL(14, 166, 6),
QT_MOC_LITERAL(15, 173, 7),
QT_MOC_LITERAL(16, 181, 13),
QT_MOC_LITERAL(17, 195, 9),
QT_MOC_LITERAL(18, 205, 16),
QT_MOC_LITERAL(19, 222, 6),
QT_MOC_LITERAL(20, 229, 14),
QT_MOC_LITERAL(21, 244, 14),
QT_MOC_LITERAL(22, 259, 6),
QT_MOC_LITERAL(23, 266, 9),
QT_MOC_LITERAL(24, 276, 12),
QT_MOC_LITERAL(25, 289, 13)
    },
    "sshExecuteCmd\0pubKeyUpdated\0\0sshkey\0"
    "pubKeyURLUpdated\0sshkeyURL\0"
    "spinnerStateUpdated\0keysGeneratedUpdated\0"
    "finished\0executeSSH\0qmlusername\0"
    "qmladdress\0qmlport\0qmlcommand\0genKey\0"
    "readKey\0publishPubKey\0keyString\0"
    "emitSpinnerState\0spinIt\0stopSpinningIt\0"
    "checkKeysExist\0pubKey\0pubKeyURL\0"
    "spinnerState\0keysGenerated\0"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_sshExecuteCmd[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      13,   14, // methods
       4,  106, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       5,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   79,    2, 0x05,
       4,    1,   82,    2, 0x05,
       6,    0,   85,    2, 0x05,
       7,    0,   86,    2, 0x05,
       8,    0,   87,    2, 0x05,

 // slots: name, argc, parameters, tag, flags
       9,    4,   88,    2, 0x0a,
      14,    0,   97,    2, 0x0a,
      15,    0,   98,    2, 0x0a,
      16,    1,   99,    2, 0x0a,
      18,    0,  102,    2, 0x0a,
      19,    0,  103,    2, 0x0a,
      20,    0,  104,    2, 0x0a,
      21,    0,  105,    2, 0x0a,

 // signals: parameters
    QMetaType::QVariant, QMetaType::QVariant,    3,
    QMetaType::QVariant, QMetaType::QVariant,    5,
    QMetaType::QVariant,
    QMetaType::QVariant,
    QMetaType::Void,

 // slots: parameters
    QMetaType::Void, QMetaType::QString, QMetaType::QString, QMetaType::QString, QMetaType::QString,   10,   11,   12,   13,
    QMetaType::Void,
    QMetaType::QString,
    QMetaType::Void, QMetaType::QString,   17,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,

 // properties: name, type, flags
      22, QMetaType::QString, 0x00495001,
      23, QMetaType::QString, 0x00495001,
      24, QMetaType::Bool, 0x00495103,
      25, QMetaType::Bool, 0x00095000,

 // properties: notify_signal_id
       0,
       1,
       2,
       0,

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
        case 2: { QVariant _r = _t->spinnerStateUpdated();
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 3: { QVariant _r = _t->keysGeneratedUpdated();
            if (_a[0]) *reinterpret_cast< QVariant*>(_a[0]) = _r; }  break;
        case 4: _t->finished(); break;
        case 5: _t->executeSSH((*reinterpret_cast< QString(*)>(_a[1])),(*reinterpret_cast< QString(*)>(_a[2])),(*reinterpret_cast< QString(*)>(_a[3])),(*reinterpret_cast< QString(*)>(_a[4]))); break;
        case 6: _t->genKey(); break;
        case 7: { QString _r = _t->readKey();
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 8: _t->publishPubKey((*reinterpret_cast< QString(*)>(_a[1]))); break;
        case 9: _t->emitSpinnerState(); break;
        case 10: _t->spinIt(); break;
        case 11: _t->stopSpinningIt(); break;
        case 12: _t->checkKeysExist(); break;
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
            typedef QVariant (sshExecuteCmd::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&sshExecuteCmd::spinnerStateUpdated)) {
                *result = 2;
            }
        }
        {
            typedef QVariant (sshExecuteCmd::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&sshExecuteCmd::keysGeneratedUpdated)) {
                *result = 3;
            }
        }
        {
            typedef void (sshExecuteCmd::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&sshExecuteCmd::finished)) {
                *result = 4;
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
        if (_id < 13)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 13;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 13)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 13;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QString*>(_v) = getPubKey(); break;
        case 1: *reinterpret_cast< QString*>(_v) = getPubKeyURL(); break;
        case 2: *reinterpret_cast< bool*>(_v) = getSpinnerState(); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 2: setSpinnerState(*reinterpret_cast< bool*>(_v)); break;
        }
        _id -= 4;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 4;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 4;
    } else if (_c == QMetaObject::RegisterPropertyMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
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
QVariant sshExecuteCmd::spinnerStateUpdated()
{
    QVariant _t0 = QVariant();
    void *_a[] = { const_cast<void*>(reinterpret_cast<const void*>(&_t0)) };
    QMetaObject::activate(this, &staticMetaObject, 2, _a);
    return _t0;
}

// SIGNAL 3
QVariant sshExecuteCmd::keysGeneratedUpdated()
{
    QVariant _t0 = QVariant();
    void *_a[] = { const_cast<void*>(reinterpret_cast<const void*>(&_t0)) };
    QMetaObject::activate(this, &staticMetaObject, 3, _a);
    return _t0;
}

// SIGNAL 4
void sshExecuteCmd::finished()
{
    QMetaObject::activate(this, &staticMetaObject, 4, 0);
}
QT_END_MOC_NAMESPACE
