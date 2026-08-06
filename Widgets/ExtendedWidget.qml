import QtQuick

import "../Types"

Row {
    Time { id: time }
    Colors { id: colors }

    WifiWidget {}
    TimeWidget {
        systemTime: time.systemTime
        textColor: colors.brightSnow
    }
    BatteryWidget {}
}
