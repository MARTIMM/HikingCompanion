#ifndef CONFIGDATA_H
#define CONFIGDATA_H

#include <QGuiApplication>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>

class ConfigData : public QObject {
  Q_OBJECT

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

  int gpxFileIndex();
  void setGpxFileIndex(int index);

  bool readProperties();

signals:

public slots:

private:
  ConfigData(QObject *parent = nullptr);
  static ConfigData *_createInstance();

  QGuiApplication *_appObject;

  QString _osType = "";
  QString _username = "";
  QString _email = "";
  int _language = 0;
  int _gpxFileIndex = 0;
};

#endif // CONFIGDATA_H
