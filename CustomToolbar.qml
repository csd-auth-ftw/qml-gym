import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolBar {
    property string subtitle

    width: parent.width
    height: 50
    style: ToolBarStyle {
        background: Rectangle {
            color: "#42f480"
        }
    }

    Text {
        id: toolBarTitle
        text: "getFit"
        anchors.left: parent.left
        font.pointSize: 22
        font.bold: true
        topPadding: 8
        color: "#0f3a1e"
    }

    Text {
        id: toolBarSubTitle
        text: subtitle
        anchors.left: toolBarTitle.right
        anchors.leftMargin: 10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        color: "#555"
    }
}
