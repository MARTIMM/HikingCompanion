#include "languages.h"

#include <QDebug>

//QList<Language *> Languages::_languages;

// ----------------------------------------------------------------------------
Languages::Languages(QObject *parent) : QObject(parent) {

  _languages.clear();

  Language *l = new Language;
  l->setName("English");
  _languages.append(l);

  l = new Language;
  l->setName("Nederlands");
  _languages.append(l);
//languagesChanged();

  qDebug() << "initialized ll:" << _languages;
}

// ----------------------------------------------------------------------------
Languages::~Languages() {

  _languages.clear();
}

// ----------------------------------------------------------------------------
QList<Language *> Languages::languageList() const {

  qDebug() << "return ll:" << _languages;
  return _languages;
}
