#ifndef HIKEMODELOBJECT_H
#define HIKEMODELOBJECT_H

#include <QObject>
#include <QVariantList>
#include <QList>
//#include <QGeoCoordinate>
//#include <QGeoPath>
//#include <QHash>
#include <QString>
#include <QLoggingCategory>

// ----------------------------------------------------------------------------
Q_DECLARE_LOGGING_CATEGORY(hikemodel)

// ----------------------------------------------------------------------------
class HikeModelObject : public QObject {

	Q_OBJECT

	Q_PROPERTY( QString listTitle READ listTitle)
	Q_PROPERTY( QString listText READ listText)
	Q_PROPERTY( QString listImage READ listImage)
	Q_PROPERTY( QString listTextFile READ listTextFile)
	Q_PROPERTY( QString listHikeKey READ listHikeKey)

public:
	explicit HikeModelObject(QObject *parent = nullptr) : QObject(parent) { }
	HikeModelObject(
	    QString lt, QString ltxt, QString li, QString lf, QString lfk
	    );
/*
	void populate(
			QString lt, QString ltxt, QString li, QString lf, QString lfk
			);
*/
	inline QString listTitle( ) { return _listTitle; }
	inline QString listText( ) { return _listText; }
	inline QString listImage( ) { return _listImage; }
	inline QString listTextFile( ) { return _listTextFile; }
	inline QString listHikeKey( ) { return _listHikeKey; }

//	void setHikeModel( );

signals:
//	void listTitleChanged();


private:
	QString _listTitle;
	QString _listText;
	QString _listImage;
	QString _listTextFile;
	QString _listHikeKey;
};

#endif // HIKEMODELOBJECT_H
