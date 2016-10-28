# determines the JavaScript provider (either Qt Script or Qt Declarative)

include(QtLinkage)

set(JS_PROVIDER "auto" CACHE STRING "specifies the JavaScript provider: auto (default), qml, script or none")
if(${JS_PROVIDER} STREQUAL "auto")
    find_qt5_module(Script OPTIONAL)
    if(QT5_Script_FOUND)
        set(JS_PROVIDER Script)
        set(JS_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_SCRIPT")
        list(APPEND ADDITIONAL_QT_REPOS "script")
        message(STATUS "No JavaScript provider explicitly specified, defaulting to Qt Script.")
    else()
        find_qt5_module(Qml OPTIONAL)
        if(QT5_Qml_FOUND)
            set(JS_PROVIDER Qml)
            set(JS_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_JSENGINE")
            list(APPEND ADDITIONAL_QT_REPOS "declarative")
            message(STATUS "No JavaScript provider explicitly specified, defaulting to Qt QML.")
        else()
            set(JS_PROVIDER "")
            set(JS_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_NO_JSENGINE")
            message(STATUS "No JavaScript provider available, features requiring JavaScript have been disabled.")
        endif()
    endif()
else()
    if(${JS_PROVIDER} STREQUAL "script")
        find_qt5_module(Script REQUIRED)
        set(JS_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_SCRIPT")
        list(APPEND ADDITIONAL_QT_REPOS "script")
        message(STATUS "Using Qt Script as JavaScript provider.")
    elseif(${JS_PROVIDER} STREQUAL "qml")
        find_qt5_module(Qml REQUIRED)
        set(JS_PROVIDER Qml)
        set(JS_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_USE_JSENGINE")
        list(APPEND ADDITIONAL_QT_REPOS "declarative")
        message(STATUS "Using Qt QML as JavaScript provider.")
    elseif(${JS_PROVIDER} STREQUAL "none")
        set(JS_PROVIDER "")
        set(JS_DEFINITION "-D${META_PROJECT_VARNAME_UPPER}_NO_JSENGINE")
        message(STATUS "JavaScript provider has been disabled.")
    else()
        message(FATAL_ERROR "The specified JavaScript provider '${JS_PROVIDER}' is unknown.")
    endif()
endif()

if(JS_PROVIDER)
    use_qt5_module(${JS_PROVIDER} OPTIONAL)
endif()
add_definitions(${JS_DEFINITION})
