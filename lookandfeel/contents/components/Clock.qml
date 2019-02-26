/*
 *   Copyright 2016 David Edmundson <davidedmundson@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU Library General Public License as
 *   published by the Free Software Foundation; either version 2 or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.8
import QtQuick.Layouts 1.1
import QtGraphicalEffects 1.0

import org.kde.plasma.core 2.0
import org.kde.plasma.components 2.0

Item {
    // If we're using software rendering, draw outlines instead of shadows
    // See https://bugs.kde.org/show_bug.cgi?id=398317
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    width: clock.implicitWidth
    height: clock.implicitHeight

    DropShadow {
        id: clockShadow
        visible: !softwareRendering
        anchors.fill: clock
        source: clock
        horizontalOffset: 0
        verticalOffset: 2
        radius: 14
        samples: 32
        spread: 0.3
        color: ColorScope.backgroundColor
    }
    
    ColumnLayout {
        id: clock
        Label {
            text: Qt.formatTime(timeSource.data["Local"]["DateTime"])
            style: softwareRendering ? Text.Outline : undefined
            styleColor: softwareRendering ? ColorScope.backgroundColor : undefined
            font.pointSize: 48
            Layout.alignment: Qt.AlignHCenter
        }
        Label {
            text: Qt.formatDate(timeSource.data["Local"]["DateTime"], Qt.DefaultLocaleLongDate)
            style: softwareRendering ? Text.Outline : undefined
            styleColor: softwareRendering ? ColorScope.backgroundColor : undefined
            font.pointSize: 24
            Layout.alignment: Qt.AlignHCenter
        }
        DataSource {
            id: timeSource
            engine: "time"
            connectedSources: ["Local"]
            interval: 1000
        }
    }
}
