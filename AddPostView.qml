import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

Rectangle {
    id: rootRectangle
    anchors.fill: parent

    property bool editing: false
    property int postIndex
    property string prevTitle
    property date prevDate
    property string prevContent
    property string prevReaction
    property int prevWeight
    property int prevCalories
    property bool prevRun

    property var photos : [];

    function reportError(txt) {
        alertDialog.text = txt;
        alertDialog.open();

        return false;
    }

    function validateInput() {
        if (titleField.text.trim().length < 1)
            return reportError("Error. Title is Empty");

        if (contentField.text.trim().length < 1)
            return reportError("Error. Content is Empty");

        if (!reactionGroup.current)
            return reportError("Error. Choose a reaction first");

        return true;
    }

    function initSelected(type) {
        if (!editing)
            return type === "yay" ? true: false;

        return type === prevReaction ? true: false;
    }

    MessageDialog {
        id: alertDialog
        visible: false
        title: "Alert"
        text: ""
        standardButtons: StandardButton.Ok
        icon: StandardIcon.Warning
    }

    CustomToolbar {
        id: mainToolBar
        subtitle: "Add a new post"
        Layout.preferredWidth: parent.width

        ToolImageButton {
            id: goBackButton
            anchors.right: parent.right
            imgSrc: "icons/back_black.png"

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
            contentHeight: formWrapper.height + 40
            interactive: true
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: formWrapper
                width: parent.width
                spacing: 10

                Column {
                    id: photosGroup
                    width: parent.width
                    spacing: 20
                    anchors.topMargin: 20
                    anchors.horizontalCenter: parent.horizontalCenter

                    FileDialog {
                        id: photosDialog
                        nameFilters: [ "Image files (*.jpg *.png)"]
                        title: "Please choose a file"
                        folder: shortcuts.pictures
                        selectFolder: false
                        selectMultiple: true
                        selectExisting: true

                        onAccepted: {
                            // check if any file got selected
                            if (this.fileUrls.length < 1)
                                return;

                            for (var i = 0; i < this.fileUrls.length; i++){
                                var photoUrl = this.fileUrls[i];
                                var resolvedUrl = Qt.resolvedUrl(photoUrl);

                                // check for duplicates
                                if (rootRectangle.photos.indexOf(resolvedUrl) >= 0)
                                    continue;

                                // add to model
                                rootRectangle.photos.push(resolvedUrl);
                                photosModel.append({"icon": photoUrl});

                                // make photo path visible
                                photosPathView.visible = true
                            }

                            photosDialog.close();
                        }

                        onRejected: {
                            photosDialog.close();
                        }

                        Component.onCompleted: visible = false
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
                                   console.log("Clicked:" + index);
                                   photosPathView.currentIndex = index

                                   selectedPhotoLarge.source = rootRectangle.photos[index]
                                   selectedPhotoLarge.visible = true
                               }

                               onDoubleClicked: {
                                    deleteDialog.currentIndex = index;
                                    deleteDialog.open();
                               }
                           }

                           MessageDialog {
                               property int currentIndex: -1

                               id: deleteDialog
                               title: "May I have your attention please"
                               text: "Do you want to remove this image?"
                               icon: StandardIcon.Warning
                               standardButtons: StandardButton.Yes | StandardButton.No

                               onYes: {
                                   if (deleteDialog.currentIndex > -1) {
                                       if (photosModel.count == 1) {
                                           photosPathView.visible = false;
                                           selectedPhotoLarge.visible = false;
                                       }

                                       photos.splice(deleteDialog.currentIndex, 1);
                                       photosModel.remove(deleteDialog.currentIndex, 1);

                                       selectedPhotoLarge.source = rootRectangle.photos[photosPathView.currentIndex]
                                   }

                                   deleteDialog.currentIndex = -1;
                               }

                               onNo: {
                                   deleteDialog.currentIndex = -1;
                               }

                               Component.onCompleted: visible = false
                           }
                       }
                    }

                    Text {
                        id: photosLabel
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "Photos"
                    }

                    Button {

                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "upload photos"

                        onClicked: {
                            photosDialog.visible=true
                        }

                    }

                    ListModel {
                        id: photosModel
                    }

                    Image {
                        id: selectedPhotoLarge
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.margins: 20
                        fillMode: Image.PreserveAspectCrop
                        width: parent.width * 0.6
                        height: 180
                        visible: false
                    }

                    PathView {
                        id: photosPathView
                        visible: false
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width
                        height: 150
                        model: photosModel
                        delegate: pathPhotoDelegate
                        path: Ellipse {
                            width: contentWrapper.width
                            height: this.height - 40
                        }
                    }
                }

                Separator {}

                Column {
                    id: titleGroup
                    width: parent.width
                    spacing: 12
                    anchors.horizontalCenter: parent.horizontalCenter

                    HighlightedText {
                        text: "Title"
                    }

                    TextField {
                        id: titleField
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.7
                        style: TextFieldStyle {
                            padding.top: 4
                            padding.bottom: 4
                            padding.right: 20
                            padding.left: 20
                        }
                        font.pixelSize: 24
                        text: prevTitle
                        placeholderText: "Post title..."
                    }
                }

                Separator {}

                // Reactions row
                RowLayout {
                    height: 100
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 10

                    ExclusiveGroup { id: reactionGroup }

                    ReactionImage {
                        reaction: "angry"
                        selected: initSelected("angry")
                    }

                    ReactionImage {
                        reaction: "sad"
                        selected: initSelected("sad")
                    }

                    ReactionImage {
                        reaction: "yay"
                        selected: initSelected("yay")
                    }

                    ReactionImage {
                        reaction: "haha"
                        selected: initSelected("haha")
                    }

                    ReactionImage {
                        reaction: "wow"
                        selected: initSelected("wow")
                    }
                }

                Separator {}

                Column {
                    id: contentGroup
                    spacing: 12
                    width: parent.width
                    anchors.horizontalCenter: parent.horizontalCenter

                    HighlightedText {
                        text: "Content"
                    }

                    TextArea {
                        id: contentField
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.pixelSize: 18
                        text: prevContent
                        width: parent.width * 0.7
                    }
                }

                Separator {}

                Column {
                    id: extraGroup
                    spacing: 10
                    anchors.horizontalCenter: parent.horizontalCenter

                    Text {
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: "More information"
                    }

                    Row {
                        spacing: 10

                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Weight"
                        }

                        TextField {
                            id: weightField
                            text: prevWeight
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Row {
                        spacing: 10

                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Calories +/-"
                        }

                        TextField {
                            id: caloriesField
                            text: prevCalories
                            anchors.verticalCenter: parent.verticalCenter
                        }
                    }

                    Row {
                        spacing: 10

                        Text{
                            anchors.verticalCenter: parent.verticalCenter
                            text: "Did you run today?"
                        }

                        CheckBox {
                            id: runCheckBox
                            anchors.verticalCenter: parent.verticalCenter
                            checked: editing && prevRun
                        }
                    }
                }

                Separator {}

                Button {
                    anchors.horizontalCenter: parent.horizontalCenter

                    style: ButtonStyle {
                        label: Text {
                            renderType: Text.NativeRendering
                            verticalAlignment: Text.AlignVCenter
                            horizontalAlignment: Text.AlignHCenter
                            font.pointSize: 18
                            padding: 8
                            color: "#333333"
                            text: !editing ? "Add Post": "Save Changes"
                        }
                    }

                    onClicked: {
                        if (!validateInput())
                            return;

                        var title = titleField.text;
                        var date = new Date();
                        var content = contentField.text;
                        var reaction = reactionGroup.current.text;
                        var weight = parseInt(weightField.text);
                        var calories = parseInt(caloriesField.text);
                        var run = runCheckBox.checked;

                        if (editing) {
                            mediator.editPost(postIndex, title, date, content, reaction, weight, calories, run, rootRectangle.photos);
                        } else {
                            mediator.insertPost(title, date, content, reaction, weight, calories, run, rootRectangle.photos);
                        }

                        mainStack.pop();
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if (editing) {
            for (var i = 0; i < photos.length; i++) {
                photosModel.append({"icon": photos[i]});

                // make photo path visible and run once
                if (i == 0)
                    photosPathView.visible = true
            }
        }
    }
}
