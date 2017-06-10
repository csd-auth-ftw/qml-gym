import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

CheckBox{
    property string labelText;
    property string labelColor: "#eee"

    checked: true
    style: CheckBoxStyle {
        label: Text {
            color: labelColor
            text : labelText
        }
    }

    onCheckedStateChanged: refreshWorkouts()
}
