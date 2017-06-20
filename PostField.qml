import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 1.4

Row {
    property string fieldText
    property string fieldIcon
    property int fieldWidth: -1
    property bool checkbox: false
    property bool fieldChecked

    width: fieldWidth < 0 ? parent.width: fieldWidth
    topPadding: 2
    bottomPadding: 2
    leftPadding: 4
    rightPadding: 4

    Image {
        source: fieldIcon
    }

    Text {
        leftPadding: 4
        text: fieldText
        visible: !checkbox ? true: false
    }

    CheckBox {
        enabled: false
        checked: fieldChecked
        visible: checkbox
    }
}
