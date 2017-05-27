import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

Rectangle {
    id: postListRootRect
    anchors.fill: parent

    function getDateText(date) {
        return "This item was posted on: " + date
    }

    Component {
        id: comp_PostView
        PostView {}
    }

    Component {
        id: comp_addPostView
        AddPostView {}
    }

    Component {
        id: postDelegate

        Item {
            width: parent.width
            height: postRow.height

            RowLayout {
                id: postRow
                width: parent.width
                height: 80
                spacing: 0

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.7
                    color: "#fafafa"

                    Text {
                        id: titleRow
                        height: 50
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 10

                        wrapMode: Text.WordWrap
                        font.pointSize: 15
                        font.weight: Font.Bold

                        text: title
                    }

                    Text {
                        id: dateRow
                        anchors.top: titleRow.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        anchors.topMargin: 0

                        text: getDateText(date)
                    }

                    MouseArea {
                        id: ma
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: ma.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

                        onClicked: {
                            var intent = {
                                "item": comp_PostView,
                                "properties": {
                                    "postIndex": index,
                                    "title": title,
                                    "date": date,
                                    "content": content,
                                    "reaction": reaction,
                                    "weight": weight,
                                    "photos": photos
                                }
                            }

                            mainStack.push(intent);
                        }
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.15
                    Layout.minimumWidth: 60
                    Layout.maximumWidth: 200
                    color: "#dddddd"

                    Column {
                        anchors.fill: parent

                        PostField {
                            fieldText: "photos: " + photos.length
                        }

                        PostField {
                            fieldText: "weight: " + weight + "kg"
                        }

                        PostField {
                            fieldText: "todo: 0000"
                        }
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.15
                    Layout.minimumWidth: 60
                    Layout.maximumWidth: 200

                    Image {
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.8
                        height: parent.height * 0.8
                        fillMode: Image.PreserveAspectFit
                        source: "reactions/" + reaction + ".png"
                    }

                }
            }

            // border bottom
            Rectangle {
                anchors.top: postRow.bottom
                width: parent.width
                height: 1
                color: "#bbb"
            }
        }
    }

    CustomToolbar {
        id: postListToolbar
        subtitle: "Diary posts"
        Layout.preferredWidth: parent.width

        ToolImageButton {
            id: goBackButton
            anchors.right: statsButton.left
            imgSrc: "icons/back_black.png"

            onClicked: {
                mainStack.pop();
            }
        }

        ToolImageButton {
            id: statsButton
            anchors.right: addNewButton.left
            imgSrc: "icons/stats_black.png"

            onClicked: {
                // TODO
            }
        }

        ToolImageButton {
            id: addNewButton
            anchors.right: parent.right
            imgSrc: "icons/add_black.png"

            onClicked: {
                mainStack.push(comp_addPostView)
            }
        }

    }

    ListView {
        spacing: 10
        anchors.top: postListToolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        model: mediator.postModel
        delegate: postDelegate
    }

}
