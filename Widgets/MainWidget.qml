import QtQuick
import QtQuick.Layouts

import "../Types"
import ".."

RowLayout {
	Time { id: time }
    Config { id: config }
    id: root

    property bool isHovered

	anchors.centerIn: parent

    WifiWidget {
        extended: root.isHovered
    }

    Item { Layout.fillWidth: true }

	TimeWidget {
		systemTime: time.systemTime
		textColor: config.surfaceColor
	}

	BatteryWidget {
        extended: root.isHovered
		Layout.alignment: Qt.AlignVCenter
	}
}
