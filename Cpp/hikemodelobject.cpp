#include "hikemodelobject.h"

// ----------------------------------------------------------------------------
Q_LOGGING_CATEGORY( hikemodel, "hc.hikemodel")

// ----------------------------------------------------------------------------
HikeModelObject::HikeModelObject(
    QString lt, QString ltxt, QString li, QString lf, QString lfk
) {
	qCDebug(hikemodel) << "hike model data:" << lt << ltxt << li << lf << lfk;

	_listTitle = lt;
	_listText = ltxt;
	_listImage = li;
	_listTextFile = lf;
	_listHikeKey = lfk;
}

/*
// ----------------------------------------------------------------------------
void HikeModelObject::populate(
		QString lt, QString ltxt, QString li,
		QString lf, QString lfk
) {

	_listTitle = lt;
	_listText = ltxt;
	_listImage = li;
	_listTextFile = lf;
	_listHikeKey = lfk;
}
*/
