import QtQuick 2.0
import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1


Rectangle {
    id: workoutListRootRect
    anchors.fill: parent
    color: "red"

    ListModel {
        id: workoutsModel
    }

    Component {
        id: mainMenuComp
        MainMenu {}
    }

    CustomToolbar {
        id: workoutListToolbar
        subtitle: "Workout List"

        ToolImageButton {
            id: backButton
            anchors.right: menuButton.left
            imgSrc: "icons/back_black.png"

            onClicked: {
                mainStack.push(mainMenuComp)
            }
        }

        ToolImageButton {
            id: menuButton
            anchors.right: parent.right
            imgSrc: "icons/menu_black.png"

            onClicked: {
                console.log("Hello i clicked menu");
            }
        }

    }

    ListView {
        Component.onCompleted: {
            var data = JSON.parse(mediator.getWorkoutsContent());

            for (var i in data.workouts) {
                workoutsModel.append(data.workouts[i]);
            }
        }
    }
}
