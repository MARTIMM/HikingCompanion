#ifndef CONFIG_H
#define CONFIG_H

#include "gpxfile.h"
#include "language.h"

#include <QGuiApplication>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>
#include <QQmlListProperty>
#include <QVector>
//#include <QList>

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
  Q_PROPERTY( QQmlListProperty<Language> languageList
              READ languageList
              WRITE setLanguageList
              NOTIFY languageListChanged
              )
  //Q_PROPERTY( QQmlListProperty<QString> tracks READ tracks)

//  struct tracks {};
//  Q_DECLARE_METATYPE(Config::tracks)

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

  // Set data for combobox lists
  void setLanguageList(QQmlListProperty<Language> list);

  QQmlListProperty<Language> languageList();
  void appendLanguage(Language *);
  int languageCount() const;
  Language *language(int) const;
  void clearLanguages();

  //QQmlListProperty<QString> tracks();

signals:
  void usernameChanged();
  void emailChanged();
  void languageChanged();
  void languageListChanged();

public slots:

private:
  static void _appendLanguage( QQmlListProperty<Language> *, Language *);
  static int _languageCount(QQmlListProperty<Language> *);
  static Language *_language( QQmlListProperty<Language> *, int);
  static void _clearLanguages(QQmlListProperty<Language> *);

  QGuiApplication *_appObject;

  // length of enum languages
  QString _langArray[nbrLang];

  QVector<Language *> _languages;
};

#endif // CONFIG_H
