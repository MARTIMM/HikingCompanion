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
