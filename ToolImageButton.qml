import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4

ToolButton {
    property string imgSrc

    id: toolBtn
    width: parent.height
    anchors.rightMargin: 5
    height: width

    background: Rectangle {
        color: toolBtn.pressed ? "#45ad69": "#49c173";
        radius: 4
        border.width: 1
        border.color: "#45ad69"
    }

    Image {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: imgSrc
        width: parent.width * 0.7
        height: width
    }
}
