import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root
    property var currentNetwork: "no.wifi.match"
	Process {
		id: getCurrentNetwork
		command: [`iwctl`, `station`, `wlan0`, `show`]
		running: true
		stdout: StdioCollector {
			onStreamFinished: {
                var outputText = this.text
                var network = parseOutputText(outputText)
                currentNetwork = network.ssid

			}
		}
	}
	Timer {
		interval: 1000
		running: true
		repeat: true
		onTriggered: getCurrentNetwork.running = true
	}

    function parseOutputText(outputText) {
        var result = {
            connected: false,
            ssid: "disconnected",
            rssi: -100,
            signalStrength: 0
        }
        var matchSsid = outputText.match(/Connected network\s+(.+)/)
        if(matchSsid && matchSsid[1]) {
            result.connected = true
            result.ssid = matchSsid[1].trim()
        }

        var matchRssi = outputText.match(/RSSI\s+(-?\d+)\s*dBm/)
        if(matchRssi && matchRssi[1]) {
            result.rssi = parseInt(matchRssi[1])

            result.percentage = Math.max(0, Math.min(100, 2 * (result.rssi + 100)))
        }
        return result
    }
}
