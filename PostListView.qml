import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

Rectangle {
    id: postListRootRect
    anchors.fill: parent
    color: "#aaa"

    function getSinceDateText(date) {
        var now = Date.now();
        var then = date.getTime();
        var diff = now - then;

        var MINUTE_MILLIS = 60 * 1000;
        var HOUR_MILLIS = 60 * MINUTE_MILLIS;
        var DAY_MILLIS = 24 * HOUR_MILLIS;
        var MONTH_MILLIS = 30 * DAY_MILLIS;
        var YEAR_MILLIS = 12 * MONTH_MILLIS;

        if (diff < MINUTE_MILLIS) {
            return "Posted moments ago";
        } else if (diff <= HOUR_MILLIS) {
            var minutes = diff / MINUTE_MILLIS;
            return "Posted " + parseInt(minutes) + " minutes ago";
        } else if (diff <= DAY_MILLIS) {
            var hours = diff / HOUR_MILLIS;
            return "Posted " + parseInt(hours) + " hours ago";
        } else if (diff <= MONTH_MILLIS) {
            var days = diff / DAY_MILLIS;
            return "Posted " + parseInt(days) + " days ago";
        } else if (diff <= YEAR_MILLIS) {
            var months = diff / MONTH_MILLIS; // not exactly right...
            return "Posted " + parseInt(months) + " months ago";
        } else {
            var years = diff / YEAR_MILLIS;
            return "Posted " + parseInt(years) + " years ago";
        }
    }

    Component {
        id: comp_PostView
        PostView {}
    }

    Component {
        id: postDelegate

        Item {
            width: parent.width
            height: postRow.height

            RowLayout {
                id: postRow
                width: parent.width
                height: 90
                spacing: 0

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.7
                    color: "#ffffff"

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
                        font.family: "Serif"
                    }

                    Text {
                        id: dateRow
                        anchors.top: titleRow.bottom
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.margins: 10
                        anchors.topMargin: 0
                        color: "#777"

                        text: getSinceDateText(date)
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
                                    "calories": calories,
                                    "run": run,
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
                    Layout.minimumWidth: 90
                    Layout.maximumWidth: 150
                    color: "#d4f4e0"

                    Column {
                        anchors.fill: parent

                        PostField {
                            fieldIcon: "icons/photos_black_xsmall.png"
                            fieldText: photos.length
                        }

                        PostField {
                            fieldIcon: "icons/weight_black_xsmall.png"
                            fieldText: (weight < 1 ? "-": weight) + " kg"
                        }

                        PostField {
                            fieldIcon: "icons/food_black_xsmall.png"
                            fieldText: (calories < 1 ? "-": calories) + " cal"
                        }

                        PostField {
                            checkbox: true
                            fieldIcon: "icons/running_black_xsmall.png"
                            fieldChecked: run
                        }
                    }
                }

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.15
                    Layout.minimumWidth: 100
                    Layout.maximumWidth: 220
                    color: "#fbfbfb"

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
        subtitle: "Progress Diary"
        Layout.preferredWidth: parent.width

        ToolImageButton {
            id: addNewButton
            anchors.right: goBackButton.left
            imgSrc: "icons/add_black.png"

            onClicked: mainStack.push(addPostViewComponent)
        }

        ToolImageButton {
            id: goBackButton
            anchors.right: parent.right
            imgSrc: "icons/menu_black.png"

            onClicked: mainStack.pop()
        }

    }

    ListView {
        spacing: 2
        anchors.top: postListToolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        model: mediator.postModel
        delegate: postDelegate
    }

    Component.onCompleted: {
        console.log("loaded")
        console.log(typeof mediator.postModel)
    }
}
