add_definitions(-DTRANSLATION_DOMAIN=\"systemmonitor\")

set (KDED_KSYSGUARD_SRCS
     kdedksysguard.cpp
)

add_library(ksysguard MODULE ${KDED_KSYSGUARD_SRCS})
kcoreaddons_desktop_to_json(ksysguard ksysguard.desktop)

target_link_libraries(ksysguard
    KF5::DBusAddons
    KF5::I18n
    KF5::XmlGui
    KF5::GlobalAccel
)

install(TARGETS ksysguard DESTINATION ${KDE_INSTALL_PLUGINDIR}/kf5/kded)

add_executable(systemmonitor ksystemactivitydialog.cpp main.cpp)

target_link_libraries(systemmonitor
    KF5::ProcessUi
    KF5::ConfigCore
    KF5::I18n
    KF5::XmlGui
    KF5::GlobalAccel
    KF5::WindowSystem
)

install(TARGETS systemmonitor DESTINATION ${KDE_INSTALL_BINDIR})
install(PROGRAMS org.kde.systemmonitor.desktop DESTINATION ${XDG_APPS_INSTALL_DIR})
