import QtQuick 2.6
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    id: mainWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("iGym")

    Component {
        id: mainComponent
        Workouts {}
    }

    StackView {
        id: mainStack
        initialItem: mainComponent
        anchors.fill: parent
    }
}
