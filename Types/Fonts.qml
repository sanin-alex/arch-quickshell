import QtQuick
import ".."

FontLoader {
    property Config config: Config { id: config }
    id: font
    source: config.fontSource
}
