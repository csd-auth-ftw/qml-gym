import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

ToolButton {
    property string imgSrc
    width: parent.height
    height: width

    Image {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        source: imgSrc
        width: parent.width * 0.7
        height: width
    }
}
