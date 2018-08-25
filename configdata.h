#ifndef CONFIGDATA_H
#define CONFIGDATA_H

#include "gpxmanager.h"

#include <QGuiApplication>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>

//#define Lang_En 0

class ConfigData : public QObject {
  Q_OBJECT

/*
  //Q_PROPERTY( QGuiApplication appObject READ appObject WRITE setAppObject)
  Q_PROPERTY( QString osType READ osType)
  Q_PROPERTY( QString username READ username WRITE setUsername)
  Q_PROPERTY( QString email READ email WRITE setEmail)
  Q_PROPERTY( int language READ language WRITE setLanguage)
  Q_PROPERTY( bool readProperties READ readProperties)
  //Q_PROPERTY( QString *readLanguageList READ readLanguageList)
*/

public:
  // This class is a singleton and the constructor should be private. Problem
  // is when registering to be usable from qml it must be public. Possibly
  // bypassing the singleton principle and create an object always.
  //ConfigData(QObject *parent = nullptr);
  static ConfigData *instance();

  // language enumerations
  enum Languages {
    English, Nederlands
  };
  Q_ENUM(Languages)

  // What system
  QString osType();
/*
  QGuiApplication *appObject();
  void setAppObject(QGuiApplication *appObjectPtr);
*/
  // Data to store
  QString username();
  void setUsername(const QString username);

  QString email();
  void setEmail(const QString email);

  int language();
  void setLanguage(const int language);

  bool readProperties();
  GpxManager *gpxManager();

signals:

public slots:

private:
  ConfigData(QObject *parent = nullptr);
  static ConfigData *_createInstance();

  QGuiApplication *_appObject;

  QString _osType;
  QString _username;
  QString _email;
  int _language;

  GpxManager *_gpxManager;
};

#endif // CONFIGDATA_H
