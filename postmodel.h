#ifndef POSTMODEL_H
#define POSTMODEL_H

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
    vector<Post> postData;

public:
    const QString modelFilename = "postmodel_data.txt";
    enum PostRoles {
        TitleRole = Qt::UserRole + 1,
        DateRole, ContentRole, ReactionRole, PhotosRole
    };

    PostModel();

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    QHash<int, QByteArray> roleNames() const;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    void insertPost(QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos);
    void editPost(int index, QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos);
    void deletePost(int index);
    void loadModel();
    void saveModel();
};

#endif // POSTMODEL_H
