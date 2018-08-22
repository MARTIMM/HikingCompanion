#ifndef CONFIG_H
#define CONFIG_H

#include "gpxmanager.h"

#include <QGuiApplication>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>

//#define Lang_En 0

class Config : public QObject {
  Q_OBJECT

  //Q_PROPERTY( QGuiApplication appObject READ appObject WRITE setAppObject)
  Q_PROPERTY( QString osType READ osType)
  Q_PROPERTY(
      QString username READ username
      WRITE setUsername NOTIFY usernameChanged
      )
  Q_PROPERTY( QString email READ email WRITE setEmail NOTIFY emailChanged)
  Q_PROPERTY(
      int language READ language
      WRITE setLanguage NOTIFY languageChanged
      )

  Q_PROPERTY( bool readProperties READ readProperties)
  Q_PROPERTY( QString *readLanguageList READ readLanguageList)

public:
  Config(QObject *parent = nullptr);

  // language enumerations, only a few
  enum Languages { English, Nederlands };
  const static int nbrLang = 2;
  Q_ENUM(Languages)

  // What system
  QString osType();
/*
  QGuiApplication *appObject();
  void setAppObject(QGuiApplication *appObjectPtr);
*/
  // Data to store
  QString username();
  void setUsername( const QString username);

  QString email();
  void setEmail( const QString email);

  int language();
  void setLanguage( const int language);

  // Emit signals
  bool readProperties();

  // Read data for combobox lists
  QString *readLanguageList();

signals:
  void usernameChanged();
  void emailChanged();
  void languageChanged();

public slots:

private:
  QGuiApplication *_appObject;
/*
  QString _osType;
  QString _username;
  QString _email;
  int _language;
*/

  // length of enum languages
  QString _langArray[nbrLang];

  GpxManager *_gpxManager;
};

#endif // CONFIG_H
