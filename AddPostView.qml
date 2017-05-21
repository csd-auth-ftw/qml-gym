import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3

Rectangle {
    id: rootRectangle
    anchors.fill: parent

    CustomToolbar {
        id: mainToolBar
        Layout.preferredWidth: parent.width

        ToolButton{
            id: goBackButton
            anchors.left: toolBarTitle.right
            width: parent.height
            height: width

            Image {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                source: "icons/back_black.png"
                width: parent.width * 0.7
                height: width
            }

            onClicked: {
                mainStack.pop();
            }
        }
    }

    Rectangle {
        id: contentWrapper
        width: parent.width > 1200 ? 1080: parent.width * 0.9
        anchors.top: mainToolBar.bottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.leftMargin: 10
        anchors.rightMargin: 10
        clip: true

        Flickable {
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: colForm.height
            interactive: true
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: formWrapper
                width: parent.width
                spacing: 10

                Column {
                    id: titleGroup
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text{
                        id: titleLabel
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Title"
                    }

                    TextField {
                        id: titleField
                        placeholderText: "Post title..."
                    }
                }

                Separator {}

                Column {
                    id: contentGroup
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text{
                        id: contentLabel
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Content"
                    }

                    TextArea {
                        id: contentField
                    }
                }
            }
        }
    }
}
