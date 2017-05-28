#ifndef MEDIATOR_H
#define MEDIATOR_H

#include "postmodel.h"
#include <QObject>

class Mediator : public QObject
{
    Q_OBJECT
    Q_PROPERTY(PostModel* postModel READ postModel WRITE setPostModel NOTIFY postModelChanged)

private:
    PostModel *_postModel;
    QString dataPath;

public:
    Mediator(QObject *parent=0);
    void setPostModel(PostModel *postModel){
        _postModel = postModel;
        emit postModelChanged();
    }

    PostModel* postModel(){
        return _postModel;
    }

signals:
    void postModelChanged();

public slots:
    void insertPost(QString title, QDateTime date, QString content, QString reaction, quint16 weight, QList<QUrl> photos);
    void editPost(int index, QString title, QDateTime date, QString content, QString reaction, quint16 weight, QList<QUrl> photos);
    void deletePost(int index);
    QString getWorkoutsContent();
    void saveAll();
};

#endif // MEDIATOR_H
