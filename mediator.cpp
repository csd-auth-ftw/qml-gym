#include "mediator.h"
#include <iostream>

Mediator::Mediator(QObject *parent): QObject(parent)
{
    _postModel = new PostModel();
}

void Mediator::insertPost(QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos)
{
    _postModel->insertPost(title, date, content, reaction, photos);
}

void Mediator::editPost(int index, QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos)
{
    _postModel->editPost(index, title, date, content, reaction, photos);
}

void Mediator::deletePost(int index)
{
    _postModel->deletePost(index);
}

void Mediator::saveAll()
{
    _postModel->saveModel();
}
