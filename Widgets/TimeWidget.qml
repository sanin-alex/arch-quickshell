import QtQuick

import "../Types"

Text {
    Fonts { id: fonts }   
	required property string systemTime
	required property string textColor
	text: systemTime 
	color: textColor
    font { 
        family: fonts.name
        pixelSize: 15 
    }	
}
