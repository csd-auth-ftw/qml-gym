import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

ColumnLayout {
    property string reaction
    property bool selected: false
    property int size: 40

    Layout.minimumWidth: (size >= 60) ? size - 20: 40
    Layout.preferredWidth: (size >= 60) ? size: 60
    Layout.minimumHeight: 80

    Rectangle {
        Layout.preferredWidth: size
        Layout.preferredHeight: size
        color: rdio.checked ? "green": "transparent"

        Image {
            width: parent.width
            height: parent.height
            fillMode: Image.PreserveAspectFit
            source: "reactions/" + reaction + ".png"

            MouseArea {
                id: ma
                hoverEnabled: true
                anchors.fill: parent
                cursorShape: ma.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

                onClicked: {
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
            text: reaction
            checked: selected
            exclusiveGroup: reactionGroup
        }
    }

}
