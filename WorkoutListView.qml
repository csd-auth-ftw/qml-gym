import QtQuick 2.0
import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.1

Rectangle {
    id: workoutListRootRect
    anchors.fill: parent
    color: "#aaa"

    property var workoutData: []

    ListModel {
        id: workoutsModel
    }

    function refreshWorkouts() {
        workoutsModel.clear();

        var filters = [];
        if(cardioCB.checkedState > 0) filters.push("cardio");
        if(calvesCB.checkedState > 0) filters.push("calves");
        if(quandsCB.checkedState > 0) filters.push("quands");
        if(quadsCB.checkedState > 0) filters.push("quads");
        if(lowerbackCB.checkedState > 0) filters.push("lower back");
        if(absCB.checkedState > 0) filters.push("abs");
        if(chestCB.checkedState > 0) filters.push("chest");
        if(bicepsCB.checkedState > 0) filters.push("biceps");

        for (var i in workoutData.workouts) {
            var workout = workoutData.workouts[i];
            var category = workout.category.toLowerCase().trim();

            if(filters.indexOf(category) >= 0)
                workoutsModel.append(workout)
        }
    }

    function setAllCheckboxes(v) {
        cardioCB.checked = v;
        calvesCB.checked = v;
        quandsCB.checked = v;
        quadsCB.checked = v;
        lowerbackCB.checked = v;
        absCB.checked = v;
        chestCB.checked = v;
        bicepsCB.checked = v;

        refreshWorkouts();
    }

    Component {
        id: myWorkoutDelegate

        Rectangle {
            width: parent.width
            height: postRow.height
            color: "#fafafa"
            clip: true

            RowLayout {
                id: postRow
                width: parent.width
                height: 100
                spacing: 10

                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.15
                    Layout.minimumWidth: 60
                    Layout.maximumWidth: 200

                    Image{
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: parent.width * 0.8
                        height: parent.height * 0.8
                        fillMode: Image.PreserveAspectFit
                        source: "workouts/" + images.get(0).image
                    }

                }


                //Start of text
                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.7
                    color: "#fafafa"

                    Text {
                        id: titleRow
                        Layout.preferredHeight: postRow.height
                        Layout.fillHeight: true
                        anchors.verticalCenter: parent.verticalCenter

                        wrapMode: Text.WordWrap
                        font.pointSize: 15
                        font.weight: Font.Bold

                        text: title
                    }

                    Text {
                        id: categoryRow
                        anchors.top: titleRow.bottom
                        anchors.left: titleRow.left
                        text: category
                        color: "#777"
                    }

                    MouseArea {
                        id: ma
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: ma.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

                        onClicked: {
                            var photos = [];
                            for (var i=0; i<images.count; i++)
                                photos.push(images.get(i));

                            var intent = {
                                "item": workoutViewComponent,
                                "properties": {
                                    "postIndex": index,
                                    "title": title,
                                    "category": category,
                                    "photos": photos,
                                    "preparation": preparation,
                                    "execution": execution
                                }
                            }

                            console.log(JSON.stringify(images, null, 2));

                            mainStack.push(intent);
                        }
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
        id: workoutListToolbar
        subtitle: "Workout List"

        ToolImageButton {
            id: filterButton
            anchors.right: menuButton.left
            imgSrc: "icons/black_filter.png"

            onClicked: filterRect.visible = !filterRect.visible
        }

        ToolImageButton {
            id: menuButton
            anchors.right: parent.right
            imgSrc: "icons/menu_black.png"

            onClicked: mainStack.push(mainMenuViewComponent)
        }

    }

    Rectangle {
        id : filterRect
        color: "#46664b"
        anchors.top: workoutListToolbar.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: parent.height  * 0.3
        visible: false
        clip: true

        Flickable{
            anchors.fill : parent
            contentWidth: parent.width
            contentHeight: filterContent.height
            interactive: true
            boundsBehavior: Flickable.StopAtBounds

            Column {
                id: filterContent
                width: parent.width

                spacing: 10

                Row {
                    padding: 10
                    width: parent.width

                    Column{
                        id: filterCol1
                        width: parent.width * 0.5
                        spacing: 3

                        FilterCheckBox {
                            id : cardioCB
                            labelText: "Cardio"
                        }

                        FilterCheckBox {
                            id : calvesCB
                            labelText: "Calves"
                        }

                        FilterCheckBox {
                            id : quadsCB
                            labelText: "Quads"
                        }

                        FilterCheckBox {
                            id : quandsCB
                            labelText: "Quands"
                        }
                    }


                    Column {
                        width: filterCol1.width
                        spacing: filterCol1.spacing

                        FilterCheckBox {
                            id : lowerbackCB
                            labelText: "Lower Back"
                        }

                        FilterCheckBox {
                            id : absCB
                            labelText: "Abs"
                        }

                        FilterCheckBox {
                            id : chestCB
                            labelText: "Chest"
                        }

                        FilterCheckBox {
                            id : bicepsCB
                            labelText: "Biceps"
                        }
                    }
                }

                Row {
                    padding: 5
                    spacing: 10
                    width: parent.width

                    Button {
                        text: "Clear All"
                        onClicked: setAllCheckboxes(false)
                    }

                    Button {
                        text: "Select All"
                        onClicked: setAllCheckboxes(true)
                    }
                }
            }
        }



    }

    ListView {
        Component.onCompleted: {

            var data = JSON.parse(mediator.getWorkoutsContent());

            for (var i in data.workouts)
            {
                var temp = data.workouts[i].images;
                var newImages = [];


                for(var j in temp)
                {
                    newImages.push({image: temp[j]});

                }

                data.workouts[i].images = newImages;
            }

            workoutData = data;

            for (var i in data.workouts) {
                workoutsModel.append(data.workouts[i]);
            }

            console.log(workoutsModel.get(0).images);


        }

        spacing: 2
        anchors.top: filterRect.visible ? filterRect.bottom : workoutListToolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        model: workoutsModel
        delegate: myWorkoutDelegate


    }
}
