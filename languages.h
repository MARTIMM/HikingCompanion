#ifndef LANGUAGES_H
#define LANGUAGES_H

#include "language.h"

#include <QObject>
#include <QVector>
#include <QList>

class Languages : public QObject {

  Q_OBJECT
  Q_PROPERTY(
      QList<Language *> languageList
      READ languageList
      NOTIFY languageListChanged
      )

public:
  explicit Languages(QObject *parent = nullptr);
  ~Languages();

  QList<Language *> languageList() const;

signals:
  void languageListChanged();

public slots:

private:

  QList<Language *> _languages;
};

#endif // LANGUAGES_H
