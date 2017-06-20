#include "mediator.h"
#include <QDir>
#include <iostream>

Mediator::Mediator(QObject *parent): QObject(parent)
{
    // set data path
    dataPath = QStandardPaths::standardLocations(QStandardPaths::DataLocation).value(0);
    QDir dir(dataPath);
    if (!dir.exists())
        dir.mkpath(dataPath);
    if (!dataPath.isEmpty() && !dataPath.endsWith("/"))
        dataPath += "/";
    dataPath += "gym_post_data.txt";

    _postModel = new PostModel(dataPath);
    std::cout << dataPath.toStdString() << std::endl;
}

void Mediator::insertPost(QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos)
{
    _postModel->insertPost(title, date, content, reaction, weight, calories, run, photos);
    emit postModelChanged();
    saveAll();
}

void Mediator::editPost(int index, QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos)
{
    _postModel->editPost(index, title, date, content, reaction, weight, calories, run, photos);
    emit postModelChanged();
    saveAll();
}

void Mediator::deletePost(int index)
{
    _postModel->deletePost(index);
    emit postModelChanged();
    saveAll();
}

void Mediator::addPoints(int points)
{
    _postModel->addPoints(points);
}

QString Mediator::getWorkoutsContent()
{
    // load cached
    if (!workoutsContent.isEmpty())
        return workoutsContent;

    // or load from file
    QFile qfile(":workouts/workouts.json");
    QTextStream qtxstream(&qfile);
    qfile.open(QIODevice::ReadOnly | QIODevice::Text);
    QString content = "", line;

    while(!qtxstream.atEnd())
    {
        line = qtxstream.readLine();
        content += line;
    }

    workoutsContent = content;
    return content;
}

void Mediator::saveAll()
{
    _postModel->saveModel();
}
