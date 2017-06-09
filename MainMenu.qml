import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

Rectangle {
    id: mainMenuRootRect
    anchors.fill: parent

    Rectangle  {
        id: workoutListLink
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: 20
        height: parent.height * 0.5 - anchors.margins*2
        color: "#42f480"
        clip: true

        Row {
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: "icons/fitness_black_2x.png"
                width: workoutListLink.width * 0.2 > 100 ? 100: workoutListLink.width * 0.2
                height: width
            }

            Text{
                text: "Workout List"
                height: parent.height
                 anchors.verticalCenter: parent.verticalCenter
            }
        }

        MouseArea{
            id: workoutMa
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: workoutMa.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

            onEntered: workoutListLink.color = "#39ce6d"
            onExited: workoutListLink.color = "#42f480"

            onClicked: mainStack.push(workoutListViewComponent)
        }
    }

    Rectangle  {
        id: blogLink
        anchors.top: workoutListLink.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20
        color: "#42f480"
        clip: true

        Row {
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: "icons/log_black_2x.png"
                width: blogLink.width * 0.2 > 100 ? 100: blogLink.width * 0.2
                height: width
            }

            Text{
                text: "Post List"
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
            }


        }

        MouseArea{
            id: postMa
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: postMa.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

            onEntered: blogLink.color = "#39ce6d"
            onExited: blogLink.color = "#42f480"

            onClicked: mainStack.push(postListViewComponent)
        }
    }


}
