#ifndef CONFIG_H
#define CONFIG_H

#include <QDebug>
#include <QObject>
#include <QSysInfo>
#include <QRegExp>
#include <QSettings>

#define Lang_En 0

class Config : public QObject {
  Q_OBJECT

  Q_PROPERTY( QString osType READ osType)
  Q_PROPERTY( QString username READ username
              WRITE setUsername NOTIFY usernameChanged
              )
  Q_PROPERTY(QString email READ email WRITE setEmail NOTIFY emailChanged)
  Q_PROPERTY(int language READ language WRITE setLanguage NOTIFY languageChanged)

  Q_PROPERTY(bool emitIt READ emitIt WRITE setEmitIt)

  Q_PROPERTY(bool readProperties READ readProperties)
  Q_PROPERTY(QString *readLanguageList READ readLanguageList)

public:
  explicit Config(QObject *parent = nullptr);

  // language enumerations
  enum Languages {
    English, Nederlands
  };
  Q_ENUM(Languages)

  // Data to store
  QString osType();
  QString username();
  QString email();
  int language();

  void setUsername( const QString username, const bool emitIt = false);
  void setEmail( const QString email, const bool emitIt = false);
  void setLanguage( const int language, const bool emitIt = false);

  // Emit toggle
  bool emitIt();

  // Read all data and emit signals
  bool readProperties();

  // Read data for combobox lists
  QString *readLanguageList();

  void setEmitIt(const bool emitIt = false);

signals:
  void usernameChanged();
  void emailChanged();
  void languageChanged();

public slots:

private:
  QString _osType;
  QString _username;
  QString _email;
  int _language;
  bool _emitIt = false;

  // length of enum languages
  QString _langArray[2];
};

#endif // CONFIG_H
