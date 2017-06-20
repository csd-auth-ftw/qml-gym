#ifndef POSTMODEL_H
#define POSTMODEL_H

#define END_OF_CONTENT "##eof_content##"

#include "post.h"
#include <QObject>
#include <QAbstractListModel>
#include <iostream>
#include <QFile>
#include <QStandardPaths>
#include <QTextStream>
#include <QUrl>

using namespace std;

class PostModel : public QAbstractListModel
{
    Q_OBJECT

private:
    int points;
    vector<Post> postData;
    QString modelFilePath;

public:
    enum PostRoles {
        TitleRole = Qt::UserRole + 1,
        DateRole, ContentRole, ReactionRole, WeightRole, CaloriesRole, RunRole, PhotosRole
    };

    PostModel(QString path);

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    void insertPost(QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos);
    void editPost(int index, QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos);
    void deletePost(int index);
    void addPoints(int points);
    void loadModel();
    void saveModel();
};

#endif // POSTMODEL_H
