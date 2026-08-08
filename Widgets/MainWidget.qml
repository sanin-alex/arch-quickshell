import QtQuick
import QtQuick.Layouts

import "../Types"

RowLayout {
	Time { id: time }
	Colors { id: colors }
    id: root

    property bool isHovered

	anchors.centerIn: parent

    WifiWidget {
        extended: root.isHovered
    }

    Item { Layout.fillWidth: true }

	TimeWidget {
		systemTime: time.systemTime
		textColor: colors.brightSnow
	}

    Item { Layout.fillWidth: true }

	BatteryWidget {
        extended: root.isHovered
		Layout.alignment: Qt.AlignVCenter
	}
}
