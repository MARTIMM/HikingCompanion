#ifndef CONFIG_H
#define CONFIG_H

#include "gpxfile.h"

#include <QGuiApplication>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>
#include <QQmlListProperty>

class Config : public QObject {
  Q_OBJECT

  //Q_PROPERTY( QGuiApplication appObject READ appObject WRITE setAppObject)
  //Q_PROPERTY( QString osType READ osType)
  Q_PROPERTY(
      QString username READ username
      WRITE setUsername NOTIFY usernameChanged
      )
  Q_PROPERTY( QString email READ email WRITE setEmail NOTIFY emailChanged)
  Q_PROPERTY(
      int languageIndex READ languageIndex
      WRITE setLanguageIndex NOTIFY languageIndexChanged
      )

  //Q_PROPERTY( bool readProperties READ readProperties)
  Q_PROPERTY(
      int gpxFileIndex READ gpxFileIndex
      WRITE setGpxFileIndex NOTIFY gpxFileIndexChanged
      )

public:
  Config(QObject *parent = nullptr);

  // language enumerations, only a few
  enum Languages { English, Nederlands };
  const static int nbrLang = 2;
  Q_ENUM(Languages)

  // What system
  //QString osType();
/*
  QGuiApplication *appObject();
  void setAppObject(QGuiApplication *appObjectPtr);
*/
  // Data to store
  QString username();
  void setUsername( const QString username);

  QString email();
  void setEmail( const QString email);

  int languageIndex();
  void setLanguageIndex( const int index);

  int gpxFileIndex();
  void setGpxFileIndex(int index);

  // Emit signals
  //bool readProperties();

signals:
  void usernameChanged();
  void emailChanged();
  void languageIndexChanged();
  void gpxFileIndexChanged();

public slots:

private:
  QGuiApplication *_appObject;
};

#endif // CONFIG_H
