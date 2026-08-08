import QtQuick
import Quickshell

Scope {
    id: root
    readonly property int mainWidgetWidth: 125 // Determines width of bar when displaying MainWidget
    readonly property int workspaceWidgetWidth: 185 // Determines width of bar when displaying WorkspaceWidget
    readonly property int extendedWidth: 325 // Determines width of bar when hovering
    readonly property int panelHeight: 35 // Determines height of panel

    readonly property bool anchorTop: true // Determines if bar anchors to top or bottom of screen
    readonly property bool reserveSpace: true // Determines if space should be reserved or if bar should be rendered over windows
}
