#ifndef SETUPLOGGING_H
#define SETUPLOGGING_H

// Uncategorized logging
#include <QDebug>


// Categorized logging. See also https://doc.qt.io/qt-5/qloggingcategory.html
#include <QLoggingCategory>

Q_LOGGING_CATEGORY( config, "hc.config")
Q_LOGGING_CATEGORY( qpx, "hc.qpx")
Q_LOGGING_CATEGORY( hikes, "hc.hikes")
Q_LOGGING_CATEGORY( lang, "hc.lang")
Q_LOGGING_CATEGORY( mainapp, "hc.main")
Q_LOGGING_CATEGORY( text, "hc.text")
Q_LOGGING_CATEGORY( track, "hc.track")
//Q_LOGGING_CATEGORY( , "hc.")

#endif // SETUPLOGGING_H
