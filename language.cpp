#include "language.h"

#include <QDebug>

// ----------------------------------------------------------------------------
Language::Language(QObject *parent) : QObject(parent) {

}

// ----------------------------------------------------------------------------
QString Language::name() {
  return _name;
}

// ----------------------------------------------------------------------------
void Language::setName(QString name) {
  if ( name.length() > 0 && name != _name ) {
    _name = name;
    emit nameChanged();
  }
}

/*
// ----------------------------------------------------------------------------
QQmlListProperty<Language> Language::languageList() {

  return QQmlListProperty<Language>(
        this, this,
        &Language::_appendLanguage,
        &Language::_languageCount,
        &Language::_language,
        &Language::_clearLanguages
        );
}

// ----------------------------------------------------------------------------
void Language::appendLanguage(Language *l) {
  _languages.append(l);
}

// ----------------------------------------------------------------------------
int Language::languageCount() const {
  return _languages.count();
}

// ----------------------------------------------------------------------------
Language *Language::language(int index) const {
  return _languages.at(index);
}

// ----------------------------------------------------------------------------
void Language::clearLanguages() {
  _languages.clear();
}

// ----------------------------------------------------------------------------
void Language::_appendLanguage( QQmlListProperty<Language> *list, Language *p) {

  qDebug() << "L:" << p;
  reinterpret_cast<Language *>(list->data)->appendLanguage(p);
}

// ----------------------------------------------------------------------------
int Language::_languageCount(QQmlListProperty<Language> *list) {

  return reinterpret_cast<Language *>(list->data)->languageCount();
}

// ----------------------------------------------------------------------------
Language *Language::_language( QQmlListProperty<Language> *list, int i) {

  return reinterpret_cast<Language *>(list->data)->language(i);
}

// ----------------------------------------------------------------------------
void Language::_clearLanguages(QQmlListProperty<Language> *list) {

  reinterpret_cast<Language *>(list->data)->clearLanguages();
}
*/
