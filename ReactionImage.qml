import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

ColumnLayout {
    property string reactionText: "no shit"
    property string imgSrc: ""
    property bool selected: false
    property int size: 70

    Layout.minimumWidth: size - 20
    Layout.preferredWidth: size
    Layout.minimumHeight: 2 * size

    Rectangle {
        Layout.preferredWidth: size
        Layout.preferredHeight: size
        color: rdio.checked ? "green": "transparent"

        Image {
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            source: imgSrc

            MouseArea {
                id: ma
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: ma.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

                onClicked: {
                    console.log("clicked image");
                    reactionGroup.current = rdio
                }
            }
        }
    }

    Rectangle {
        Layout.preferredWidth: size
        Layout.preferredHeight: size/2

        RadioButton {
            id: rdio
            anchors.horizontalCenter: parent.horizontalCenter
            text: reactionText
            checked: selected
            exclusiveGroup: reactionGroup
        }
    }

}
