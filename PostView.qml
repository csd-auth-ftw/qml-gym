import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

Rectangle {
    id: postViewRootRect
    anchors.fill: parent

    property int postIndex: -1
    property string title
    property date date;
    property string content;
    property string reaction;
    property int weight;
    property int calories;
    property bool run;
    property var photos: []

    ListModel {
        id: photosModel
    }

    Component {
        id: pathPhotoDelegate

        Column {
           spacing: 2
           scale: PathView.iconScale
           opacity: PathView.iconOpacity
           rotation: PathView.itemRotation

           MouseArea {
               width:64
               height:64

               Image {
                   width: parent.width
                   height: parent.height
                   source: icon
                   asynchronous: true
                   fillMode: Image.PreserveAspectFit
               }

               onClicked: {
                   photosPathView.currentIndex = index
                   postCoverImage.source = postViewRootRect.photos[index]
               }
           }

        }
    }

    CustomToolbar {
        id: mainToolBar
        Layout.preferredWidth: parent.width

        ToolImageButton {
            id: goBackButton
            anchors.right: editButton.left
            imgSrc: "icons/back_black.png"

            onClicked: {
                mainStack.pop();
            }
        }

        ToolImageButton {
            id: editButton
            anchors.right: deleteButton.left
            imgSrc: "icons/edit_black.png"

            onClicked: {

            }
        }

        ToolImageButton {
            id: deleteButton
            anchors.right: parent.right
            imgSrc: "icons/delete_black.png"

            onClicked: {
                mediator.deletePost(postIndex);
                mainStack.pop();
            }
        }
    }

    Flickable {
        anchors.top: mainToolBar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        contentWidth: parent.width
        contentHeight: parent.height + 40 // TODO
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds

        Column {
            id: mainColumn
            anchors.fill: parent

            Image {
                id: postCoverImage
                visible: false
                fillMode: Image.PreserveAspectCrop
                height: 200
                width: parent.width
            }

            PathView {
                id: photosPathView
                visible: false
                anchors.horizontalCenter: parent.horizontalCenter
                width: parent.width * 0.75
                height: 120
                model: photosModel
                delegate: pathPhotoDelegate
                path: Ellipse {
                    width: photosPathView.width
                    height: photosPathView.height * 0.85
                }
            }

            Text {
                text: title
                width: parent.width * 0.8
                anchors.margins: 20
                anchors.horizontalCenter: parent.horizontalCenter
                font.pointSize: 22
                wrapMode: Text.WordWrap
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignHCenter
            }

            Image {
                width: 35
                height: 35
                fillMode: Image.PreserveAspectFit
                anchors.margins: 20
                anchors.topMargin: 0
                anchors.horizontalCenter: parent.horizontalCenter
                source: "reactions/" + reaction + ".png"
            }

        }
    }

    Component.onCompleted: {
        if (postIndex < 0)
            return mainStack.pop();

        if (photos.length > 0) {
            postCoverImage.visible = true;     
            postCoverImage.source = photos[0];
        }

        if (photos.length > 1) {
            photosPathView.visible = true;

            for (var i in photos) {
                photosModel.append({"icon": photos[i]});
            }
        }
    }
}
