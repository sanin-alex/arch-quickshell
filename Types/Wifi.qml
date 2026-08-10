import QtQuick
import Quickshell
import Quickshell.Io

Scope {
    id: root
    property string currentNetwork: "no.wifi.match"
    property string signalStrengthSymbol: "no.signal"
	Process {
		id: getCurrentNetwork
		command: [`iwctl`, `station`, `wlan0`, `show`]
		running: true
		stdout: StdioCollector {
			onStreamFinished: {
                var outputText = this.text
                var network = root.parseOutputText(outputText)
                root.currentNetwork = network.ssid
                root.signalStrengthSymbol = root.getWifiSymbol(network)
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

            result.signalStrength = Math.max(0, Math.min(100, 2 * (result.rssi + 100)))
        }
        return result
    }

    function getWifiSymbol(network) {
        if(!network.connected) { return "󰤭" }
        if(network.signalStrength <= 10) { return "󰤫" }
        if(network.signalStrength <= 25) { return "󰤯" }
        if(network.signalStrength <= 50) { return "󰤟" }
        if(network.signalStrength <= 75) { return "󰤥" }
        if(network.signalStrength <= 100) { return "󰤨" }
    }
}
