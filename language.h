#ifndef LANGUAGE_H
#define LANGUAGE_H

#include <QObject>
#include <QQmlListProperty>
#include <QVector>

// ----------------------------------------------------------------------------
class Language : public QObject {

  Q_OBJECT
  Q_PROPERTY( QString name READ name WRITE setName NOTIFY nameChanged)
//  Q_PROPERTY( QQmlListProperty<Language> languageList READ languageList)

public:
  explicit Language(QObject *parent = nullptr);

  QString name();
  void setName(QString name);

/*
  // Read data for combobox lists
  QQmlListProperty<Language> languageList();
  void appendLanguage(Language *);
  int languageCount() const;
  Language *language(int) const;
  void clearLanguages();
*/

signals:
  void nameChanged();

public slots:

private:
/*
  static void _appendLanguage( QQmlListProperty<Language> *, Language *);
  static int _languageCount(QQmlListProperty<Language> *);
  static Language *_language( QQmlListProperty<Language> *, int);
  static void _clearLanguages(QQmlListProperty<Language> *);
*/

  QString _name;
//  QVector<Language *> _languages;
};

#endif // LANGUAGE_H
