import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1


Rectangle {
    id: workoutViewRootRect
    anchors.fill: parent

    property int postIndex: -1;
    property int imageIndex;
    property string title;
    property string category;
    property var photos: []
    property string preparation;
    property string execution;

    CustomToolbar {
        id: mainToolBar
        Layout.preferredWidth: parent.width

        ToolImageButton {
            id: goBackButton
            anchors.right: parent.right
            imgSrc: "icons/back_black.png"

            onClicked: mainStack.pop()
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
            contentHeight: mainColumn.height + 40 // TODO
            interactive: true
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: mainColumn
                width: parent.width
                spacing: 20

                Image {
                    id: postCoverImage
                    fillMode: Image.PreserveAspectFit
                    anchors.horizontalCenter: parent.horizontalCenter
                    height: 300
                    width: parent.width
                }

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    padding: 10
                    spacing: 5

                    Button {
                        iconSource: "icons/left_black_small.png"
                        onClicked: {
                            imageIndex = (imageIndex-1) < 0 ? photos.length - 1: imageIndex-1;
                            postCoverImage.source = "workouts/" + photos[imageIndex].image;
                        }
                    }

                    Button {
                        iconSource: "icons/right_black_small.png"
                        onClicked: {
                            imageIndex = (imageIndex+1) % photos.length;
                            postCoverImage.source = "workouts/" + photos[imageIndex].image;
                        }
                    }
                }

                Text {
                    text: title
                    width: parent.width * 0.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 24
                    wrapMode: Text.WordWrap
                    font.weight: Font.Bold
                    horizontalAlignment: Text.AlignHCenter
                }

                HighlightedText {
                    text: "preparation"
                }

                Text {
                    text: workoutViewRootRect.preparation
                    wrapMode: Text.Wrap
                    width: parent.width
                    horizontalAlignment: Text.AlignHCenter
                }

                HighlightedText {
                    text: "execution"
                }

                Text {
                    text: workoutViewRootRect.execution
                    width: parent.width
                    wrapMode: Text.Wrap
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }

    }


    Component.onCompleted: {
        if (postIndex < 0)
            return mainStack.pop();

        imageIndex = 0;
        postCoverImage.source = "workouts/" + photos[imageIndex].image;
    }
}
