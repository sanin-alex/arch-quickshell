import QtQuick
import QtQuick.Layouts

import "../Types"

RowLayout {
	Time { id: time }
	Colors { id: colors }

	anchors.centerIn: parent
	TimeWidget {
		systemTime: time.systemTime
		textColor: colors.brightSnow
	}
	Item { Layout.fillWidth: true }
	BatteryWidget {
		Layout.alignment: Qt.AlignVCenter
	}
}
