import QtQuick 2.0
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
        text: "iGym2"
        anchors.left: parent.left
        font.pointSize: 20
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
