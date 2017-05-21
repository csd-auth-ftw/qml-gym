import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

ColumnLayout {
    anchors.fill: parent
    spacing: 0

    Component {
        id: comp_addPostView
        AddPostView {}
    }

    CustomToolbar {
        Layout.preferredWidth: parent.width

        ToolButton{
            id: addPostButton
            anchors.left: toolBarTitle.right
            width: parent.height
            height: width

            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "icons/add_black.png"
                width: parent.width * 0.7
                height: width
            }

            onClicked: {
                mainStack.push(comp_addPostView);
            }
        }
    }

    Rectangle {
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height * 0.5
        color: "red"
    }

    Rectangle {
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: parent.height * 0.5
        color: "blue"
    }
}
