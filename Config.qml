import QtQuick
import Quickshell

import "Types"

Scope {
    id: root

    Colors { id: colors }

    readonly property int mainWidgetWidth: 125 // Determines width of bar when displaying MainWidget
    readonly property int workspaceWidgetWidth: 185 // Determines width of bar when displaying WorkspaceWidget

    readonly property bool extendOnHover: true // Determines if bar extends when hovering
    readonly property int extendedWidth: 325 // Determines width of bar when hovering

    readonly property int panelHeight: 35 // Determines height of the panel, which contains the bar
    readonly property string panelColor: colors.transparent // Determines the color of the panel, which contains the bar

    readonly property bool anchorTop: true // Determines if bar anchors to top or bottom of screen
    readonly property bool reserveSpace: true // Determines if space should be reserved or if bar should be rendered over windows

    readonly property int animationDuration: 200 // Determines the speed of all animations

    readonly property string transparentColor: colors.transparent

    readonly property string surfaceColor: colors.white
    readonly property string backgroundColor: colors.black
    readonly property string disabledColor: colors.grey50
    readonly property string usedColor: colors.grey35
    readonly property string unusedColor: colors.grey25

    readonly property string batteryStandardColor: colors.white
    readonly property string batteryChargingColor: colors.green
    readonly property string batteryWarningColor: colors.yellow
    readonly property string batteryCriticalColor: colors.red
}
