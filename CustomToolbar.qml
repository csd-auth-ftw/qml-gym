import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

ToolBar {
    width: parent.width
    height: 40

    Text {
        id: toolBarTitle
        text: "iGym2"
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        font.pointSize: 20
    }
}
