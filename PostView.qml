import QtQuick 2.7
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

            onClicked: mainStack.pop();
        }

        ToolImageButton {
            id: editButton
            anchors.right: deleteButton.left
            imgSrc: "icons/edit_black.png"

            onClicked: {
                var intent = {
                    "item": addPostViewComponent,
                    "properties": {
                        "editing": true,
                        "postIndex": postIndex,
                        "prevTitle": title,
                        "prevDate": date,
                        "prevContent": content,
                        "prevReaction": reaction,
                        "prevWeight": weight,
                        "prevCalories": calories,
                        "prevRun": run,
                        "photos": photos
                    }
                }

                mainStack.push(intent);
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

    Rectangle {
        id: contentWrapper
        width: parent.width
        anchors.top: mainToolBar.bottom
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true

        Flickable {
            anchors.fill: parent
            contentWidth: parent.width
            contentHeight: mainColumn.height + 20
            interactive: true
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: mainColumn
                width: parent.width

                Image {
                    id: postCoverImage
                    visible: false
                    fillMode: Image.PreserveAspectCrop
                    height: 240
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

                Separator {}

                Text {
                    text: title
                    width: parent.width * 0.8
                    padding: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pointSize: 22
                    wrapMode: Text.WordWrap
                    font.weight: Font.Bold
                    horizontalAlignment: Text.AlignHCenter
                }

                Rectangle {
                    width: parent.width
                    height: 70

                    Image {
                        width: parent.height * 0.8
                        height: width
                        fillMode: Image.PreserveAspectFit
                        anchors.horizontalCenter: parent.horizontalCenter
                        source: "reactions/" + reaction + ".png"
                    }
                }

                Separator {}

                Rectangle {
                    width: extrasRow.width
                    height: 40
                    anchors.horizontalCenter: mainColumn.horizontalCenter

                    Row {
                        id: extrasRow
                        anchors.top: parent.top
                        anchors.topMargin: 10

                        PostField {
                            fieldIcon: "icons/photos_black_xsmall.png"
                            fieldText: photos.length
                            fieldWidth: 60
                        }

                        PostField {
                            fieldIcon: "icons/weight_black_xsmall.png"
                            fieldText: (weight < 1 ? "-": weight) + " kg"
                            fieldWidth: 100
                        }

                        PostField {
                            fieldIcon: "icons/food_black_xsmall.png"
                            fieldText: (calories < 1 ? "-": calories) + " cal"
                            fieldWidth: 100
                        }

                        PostField {
                            checkbox: true
                            fieldIcon: "icons/running_black_xsmall.png"
                            fieldChecked: run
                            fieldWidth: 60
                        }
                    }
                }

                Separator {}


                Text {
                    width: parent.width * 0.8
                    anchors.horizontalCenter: parent.horizontalCenter
                    wrapMode: Text.WordWrap
                    padding: 20
                    font.pixelSize: 18
                    text: content
                }
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
