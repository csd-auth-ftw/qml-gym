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
        height: parent.height*0.5
        color: "red"

        Row {
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: "icons/add_black.png"
                width: 100
                height: 100
            }

            Text{
                text: "Workout List"
                height: parent.height
                 anchors.verticalCenter: parent.verticalCenter
            }
        }

        MouseArea{
            anchors.fill: parent
            onClicked: mainStack.push(workoutListViewComponent)
        }
    }

    Rectangle  {
        anchors.top: workoutListLink.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        color:"blue"

        Row {
            width: parent.width * 0.8
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            Image {
                source: "icons/menu_black.png"
                width: 100
                height: 100
            }

            Text{
                text: "Post List"
                height: parent.height
                anchors.verticalCenter: parent.verticalCenter
            }


        }

        MouseArea{
            anchors.fill: parent
            onClicked: mainStack.push(postListViewComponent)
        }
    }


}
