import QtQuick 2.0
import QtCharts 2.2

Rectangle {
    id: postListRootRect
    anchors.fill: parent

    CustomToolbar {
        id: statsToolbar
        subtitle: "Stats"

        ToolImageButton {
            id: goBackButton
            anchors.right: parent.right
            imgSrc: "icons/back_black.png"

            onClicked: {
                mainStack.pop();
            }
        }

    }

    Column {
        anchors.fill: parent

        ChartView {
            title: "Scatters"
            anchors.fill: parent
            antialiasing: true

            ScatterSeries {
                id: weightScatter

                XYPoint { x: 1.5; y: 1.5 }
                XYPoint { x: 1.5; y: 1.6 }
                XYPoint { x: 1.57; y: 1.55 }
            }
        }
    }
}
