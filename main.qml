import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: mainWindow
    visible: true
    width: 480
    height: 640
    title: qsTr("getFit - your personal workout trainer")

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
