import QtQuick
import Quickshell

import "../Types"

Text {
	text: Wifi.currentNetwork 
    color: Colors.brightSnow
	font { pixelSize: 15 }	
}
