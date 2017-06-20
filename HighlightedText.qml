import QtQuick 2.0

Rectangle {
    property string text;
    property int textPadding: 10;

    id: rect
    color: "#42f480"
    anchors.horizontalCenter: parent.horizontalCenter
    width: txt.width + textPadding
    height: txt.height + textPadding

    Text {
        id: txt
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: rect.textPadding / 2
        text: rect.text.toUpperCase()
    }
}
