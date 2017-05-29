import QtQuick 2.0
import QtQuick.Layouts 1.3

Rectangle {
    property string fieldText

    width: parent.width
    height: parent.height * 0.25

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        text: fieldText
    }
}
