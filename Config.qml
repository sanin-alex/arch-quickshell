pragma Singleton
import QtQuick
import "Types"

QtObject {
    id: root

    property Colors colors: Colors { id: colors }

    // Bar
    readonly property int mainWidgetWidth: 125 // Determines width of bar when displaying MainWidget
    readonly property int workspaceWidgetWidth: 185 // Determines width of bar when displaying WorkspaceWidget
    readonly property bool anchorTop: true // Determines if bar anchors to top or bottom of screen
    readonly property bool extendOnHover: true // Determines if bar extends when hovering
    readonly property int extendedWidth: 325 // Determines width of bar when hovering
    readonly property int borderWidth: 0 // Determines width of border around bar (0 to disable)

    // Panel
    readonly property bool reserveSpace: true // Determines if space should be reserved or if bar should be rendered over windows
    readonly property int panelHeight: 35 // Determines height of the panel, which contains the bar

    // Animations
    readonly property int animationDuration: 200 // Determines the speed of all animations

    // Colors
    readonly property bool darkMode: true // Flips monochrome colors

    readonly property string transparentColor: colors.transparent

    readonly property string surfaceColor: darkMode ? colors.white : colors.black
    readonly property string backgroundColor: darkMode ? colors.black : colors.white
    readonly property string disabledColor: darkMode ? colors.grey75: colors.grey25
    readonly property string usedColor: darkMode ? colors.grey50 : colors.grey35
    readonly property string unusedColor: darkMode ? colors.grey25 : colors.grey75

    readonly property string batteryStandardColor: colors.white
    readonly property string batteryChargingColor: colors.green
    readonly property string batteryWarningColor: colors.yellow
    readonly property string batteryCriticalColor: colors.red

    // Font
    readonly property string fontSource: "../fonts/retro-floral.regular.otf"
}
