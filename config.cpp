#include "config.h"
#include "configdata.h"
#include "gpxfile.h"

#include <QDebug>

// ----------------------------------------------------------------------------
// See also http://blog.qt.io/blog/2017/12/01/sharing-files-android-ios-qt-app/
// to use Q_OS_IOS, Q_OS_ANDROID etc.
// ----------------------------------------------------------------------------
Config::Config(QObject *parent) : QObject(parent) {

  // See also http://doc.qt.io/qt-5/qguiapplication.html#platformName-prop
  // For me it could be: android, ios or xcb (x11 on linux)
  //qDebug() << "platform name: " << app.platformName();

  //_osType = QString(app.platformName());
}

// ----------------------------------------------------------------------------
QString Config::osType() {

  ConfigData *c = ConfigData::instance();
  return c->osType();
}

/*
// ----------------------------------------------------------------------------
QGuiApplication *Config::appObject() {
  return _appObject;
}

// ----------------------------------------------------------------------------
void Config::setAppObject(QGuiApplication *appObject) {
  _appObject = appObject;  //qobject_cast<QApplication *>(appObjectPtr);
}
*/

// ----------------------------------------------------------------------------
QString Config::username() {

  ConfigData *c = ConfigData::instance();
  return c->username();
}

// ----------------------------------------------------------------------------
void Config::setUsername(const QString username) {

  ConfigData *c = ConfigData::instance();

  if ( c->username() != username ) {
    c->setUsername(username);
    emit usernameChanged();
  }
}

// ----------------------------------------------------------------------------
QString Config::email() {

  ConfigData *c = ConfigData::instance();
  return c->email();
}

// ----------------------------------------------------------------------------
void Config::setEmail(const QString email) {

  ConfigData *c = ConfigData::instance();

  if ( c->email() != email ) {
    c->setEmail(email);
    emit emailChanged();
  }
}

// ----------------------------------------------------------------------------
int Config::language() {

  ConfigData *c = ConfigData::instance();
  return c->language();
}

// ----------------------------------------------------------------------------
void Config::setLanguage(const int language) {

  ConfigData *c = ConfigData::instance();

  if ( c->language() != language ) {
    c->setLanguage(language);
    emit languageChanged();
  }
}

/*
// ----------------------------------------------------------------------------
QQmlListProperty<QString> Config::tracks() {

  ConfigData *c = ConfigData::instance();
  _gpxFileList = c->gpxManager()->gpxFileList();

  QVector<QString *> gpxTrackNames;
  static QString s = "abc";
  gpxTrackNames.push_back(&s);
/ *
  for ( int i = 0; i < _gpxFileList.count(); i++) {
    GpxFile *gf = _gpxFileList.at(i);
    gpxTrackNames << gf->trackName();
  }
* /

  this->setProperty( "tracks", gpxTrackNames);
  return QQmlListProperty<QString>( this, gpxTrackNames);
}
*/

// ----------------------------------------------------------------------------
// emit all property signals so as to force listeners to update their data
bool Config::readProperties() {

  emit usernameChanged();
  emit emailChanged();
  emit languageChanged();

  return true;
}

// ----------------------------------------------------------------------------
void Config::setLanguageList(QQmlListProperty<Language> list) {
  _languages.clear();

  Language l;
  l.setName("English");
  _languages.append(&l);
  l.setName("Nederlands");
  _languages.append(&l);

  emit languageListChanged();
}

// ----------------------------------------------------------------------------
// Called from QML to get methods to modify stuff
QQmlListProperty<Language> Config::languageList() {
/*
  Language l;
  l.setName("English");
  _languages.append(&l);
  l.setName("Nederlands");
  _languages.append(&l);
*/

  return QQmlListProperty<Language>(
        this, this,
        &Config::_appendLanguage,
        &Config::_languageCount,
        &Config::_language,
        &Config::_clearLanguages
        );
}

// ----------------------------------------------------------------------------
void Config::appendLanguage(Language *l) {
  qDebug() << "L2:" << l->name();
  _languages.append(l);
}

// ----------------------------------------------------------------------------
int Config::languageCount() const {
  return _languages.count();
}

// ----------------------------------------------------------------------------
Language *Config::language(int index) const {
  return _languages.at(index);
}

// ----------------------------------------------------------------------------
void Config::clearLanguages() {
  _languages.clear();
}

// ----------------------------------------------------------------------------
// Called from QML to add a Language object to _languages using public
// Config::appendLanguage method.

void Config::_appendLanguage( QQmlListProperty<Language> *list, Language *p) {

  qDebug() << "L1:" << p->name();
  reinterpret_cast<Config *>(list->data)->appendLanguage(p);
}

// ----------------------------------------------------------------------------
int Config::_languageCount(QQmlListProperty<Language> *list) {

  return reinterpret_cast<Config *>(list->data)->languageCount();
}

// ----------------------------------------------------------------------------
Language *Config::_language( QQmlListProperty<Language> *list, int i) {

  return reinterpret_cast<Config *>(list->data)->language(i);
}

// ----------------------------------------------------------------------------
void Config::_clearLanguages(QQmlListProperty<Language> *list) {

  reinterpret_cast<Config *>(list->data)->clearLanguages();
}
