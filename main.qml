import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("iGym")

    /** top level views components **/
    Component {
        id: mainMenuViewComponent
        MainMenu {}
    }

    Component {
        id: workoutListViewComponent
        WorkoutListView {}
    }

    Component {
        id: workoutViewComponent
        WorkoutView {}
    }

    Component {
        id: postListViewComponent
        PostListView{}
    }

    Component {
        id: addPostViewComponent
        AddPostView {}
    }

    /** the main view stack **/
    StackView {
        id: mainStack
        initialItem: workoutListViewComponent
        anchors.fill: parent
    }
}
