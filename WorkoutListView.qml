import QtQuick 2.0
import QtQuick 2.2
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
    Component {
        id: comp_WorkoutView
        WorkoutView {}
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
            var cat = workoutData.workouts[i].category.toLowerCase().trim();

            if(filters.indexOf(cat) >= 0) {
                workoutsModel.append(workoutData.workouts[i])
            }
        }
    }


    Component {
        id: mainMenuComp
        MainMenu {}
    }

    Component {
        id: myWorkoutDelegate

        Rectangle {
            width: parent.width
            height: postRow.height
            color: "#fafafa"


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
                        source: "workouts/"+images.get(0).image
                    }

                }


                //Start of text
                Rectangle {
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    Layout.preferredWidth: parent.width * 0.7

                    //        Layout.preferredHeight: postRow.height
                    //        height:postRow.height
                    color: "#fafafa"

                    Text {
                        id: titleRow
                        Layout.preferredHeight: postRow.height
                        Layout.fillHeight: true


                        // anchors.top: parent.top
                        //  anchors.left: parent.left
                        //  anchors.right: parent.right
                        //   anchors.margins: 10


                        anchors.verticalCenter: parent.verticalCenter

                        wrapMode: Text.WordWrap
                        font.pointSize: 15
                        font.weight: Font.Bold

                        text: title
                    }



                    MouseArea {
                        id: ma
                        hoverEnabled: true
                        anchors.fill: parent
                        cursorShape: ma.containsMouse ? Qt.PointingHandCursor: Qt.ArrowCursor

                        onClicked: {
                            var intent = {
                                "item": comp_WorkoutView,
                                "properties": {
                                    "postIndex": index,
                                    "title": title,
                                    "category":category,
                                    "photos":images,
                                    "preparation":preparation,
                                    "execution":execution
                                }
                            }

                            mainStack.push(intent);
                        }
                    }
                }
                //end of text

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

            onClicked: {
                mainStack.push(mainMenuComp)
            }
        }

    }

    Rectangle {
        id : filterRect
        color: "#888"
        anchors.top:workoutListToolbar.bottom
        anchors.left : parent.left
        anchors.right : parent.right
        height:parent.height  * 0.2
        visible: false
        clip: true

        Flickable{
            anchors.fill : parent
            contentWidth: parent.width
            contentHeight: parent.height +10
            interactive: true
            boundsBehavior: Flickable.StopAtBounds


            Row
            {
                anchors.fill : parent

                Column{
                    width: parent.width * 0.5
                    height: parent.height

                    CheckBox{
                        id : cardioCB
                        text : "Cardio"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()
                    }

                    CheckBox{
                        id : calvesCB
                        text : "Calves"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

                    }
                    CheckBox{
                        id :quadsCB
                        text : "Quads"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

                    }

                    CheckBox{
                        id :quandsCB
                        text : "Quands"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

                    }

                }


                Column{
                    width: parent.width * 0.5
                    height: parent.height


                    CheckBox{
                        id : lowerbackCB
                        text : "Lower Back"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

                    }

                    CheckBox{
                        id : absCB
                        text : "Abs"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

                    }
                    CheckBox{
                        id :chestCB
                        text : "Chest"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

                    }
                    CheckBox{
                        id :bicepsCB
                        text : "Biceps"
                        checked: true
                        onCheckedStateChanged: refreshWorkouts()

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

        spacing: 5
        anchors.top: filterRect.visible ? filterRect.bottom : workoutListToolbar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        clip: true

        model: workoutsModel
        delegate: myWorkoutDelegate


    }
}
