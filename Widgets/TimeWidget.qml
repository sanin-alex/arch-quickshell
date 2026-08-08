import QtQuick

import "../Types"

Text {
    Fonts { id: fonts }   
	required property var systemTime
	required property var textColor
	text: systemTime 
	color: textColor
    font { 
        family: fonts.name
        pixelSize: 15 
    }	
}
