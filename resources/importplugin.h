#ifndef MISC_UTILS_IMPORT_PLUGIN_H
#define MISC_UTILS_IMPORT_PLUGIN_H

#include "resources/qtconfig.h"

#ifdef QT_STATIC
#if defined(QT_UTILITIES_GUI_QTWIDGETS) || defined(QT_UTILITIES_GUI_QTQUICK)
#include <QtPlugin>
#ifdef Q_OS_WIN32
Q_IMPORT_PLUGIN(QWindowsIntegrationPlugin)
#endif
#ifdef Q_OS_MACOS
Q_IMPORT_PLUGIN(QCocoaIntegrationPlugin)
#endif
#ifdef SVG_SUPPORT
Q_IMPORT_PLUGIN(QSvgPlugin)
#endif
#ifdef SVG_ICON_SUPPORT
Q_IMPORT_PLUGIN(QSvgIconPlugin)
#endif
#ifdef IMAGE_FORMAT_SUPPORT
IMPORT_IMAGE_FORMAT_PLUGINS
#endif
IMPORT_WIDGET_STYLE_PLUGINS
#endif // defined(QT_UTILITIES_GUI_QTWIDGETS) || defined(QT_UTILITIES_GUI_QTQUICK)
IMPORT_TLS_PLUGINS
#endif // QT_STATIC

#endif // MISC_UTILS_IMPORT_PLUGIN_H
