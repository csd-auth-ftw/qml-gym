#include "postmodel.h"

PostModel::PostModel()
{
    loadModel();
}

int PostModel::rowCount(const QModelIndex &parent) const
{
    return postData.size();
}

QHash<int, QByteArray> PostModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TitleRole] = "title";
    roles[DateRole] = "date";
    roles[ContentRole] = "content";
    roles[ReactionRole] = "reaction";
    roles[PhotosRole] = "photos";
    return roles;
}

QVariant PostModel::data(const QModelIndex &index, int role) const
{
    int row = index.row();
    if (row < 0 || row >= rowCount())
        return QVariant();

    Post p = postData[row];
    switch (role)
    {
        case TitleRole: return p.getTitle();
        case DateRole: return p.getDate();
        case ContentRole: return p.getContent();
        case ReactionRole: return p.getReaction();
        case PhotosRole: return QVariant::fromValue(p.getPhotos());
        default: return QVariant();
    }
}

void PostModel::insertPost(QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos)
{
    beginResetModel();

    Post post(title, date, content, reaction, photos);
    postData.push_back(post);

    endResetModel();
}

void PostModel::editPost(int index, QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos)
{
    beginResetModel();
    
    int size = postData.size();
    if(index > -1 && index < size)
    {
        postData[index].setTitle(title);
        postData[index].setDate(date);
        postData[index].setContent(content);
        postData[index].setReaction(reaction);
        postData[index].setPhotos(photos);
    }

    endResetModel();
}

void PostModel::deletePost(int index)
{
    beginResetModel();

    vector<Post>::iterator itr = postData.begin();
    advance(itr, index);

    if(index != -1)
        postData.erase(itr);

    endResetModel();
}

void PostModel::loadModel()
{
    cout << "Loading post model..." << endl;

    QFile qfile(modelFilename);
    QTextStream qtxstream(&qfile);
    qfile.open(QIODevice::ReadOnly | QIODevice::Text);

    int rows = qtxstream.readLine().toInt();
    for (int i=0; i<rows; i++)
    {
        QString title = qtxstream.readLine();
        QDate date = QDate::fromString(qtxstream.readLine(), "ddd dd MMM yyyy");
        QString content = qtxstream.readLine(); // TODO multiline content
        quint16 reaction = qtxstream.readLine().toInt();

        int photos_n = qtxstream.readLine().toInt();
        QList<QUrl> photos = QList<QUrl>();
        for (int j=0; j<photos_n; j++)
        {
            QUrl url(qtxstream.readLine());
            photos.append(url);
        }

        insertPost(title, date, content, reaction, photos);
    }

    qfile.close();
}

void PostModel::saveModel()
{
    cout << "Saving post model..." << endl;
    
    QFile qfile(modelFilename);
    QTextStream qtxstream(&qfile);
    qfile.open(QIODevice::WriteOnly | QIODevice::Text);

    // write the number of rows first
    qtxstream << rowCount() << endl;

    // write each post data
    vector<Post>::iterator itr;
    for (itr = postData.begin(); itr != postData.end(); itr++)
    {
        qtxstream << itr->getTitle() << endl;
        qtxstream << itr->getDate().toString("ddd dd MMM yyyy") << endl;
        qtxstream << itr->getContent() << endl;
        qtxstream << itr->getReaction() << endl;

        QList<QUrl> photos = itr->getPhotos();
        qtxstream << photos.size() << endl;
        if (!photos.isEmpty())
        {
            QList<QUrl>::iterator p_itr;
            for (p_itr = photos.begin(); p_itr != photos.end(); p_itr++)
            {
                qtxstream << p_itr->toString().toUtf8() << endl;
            }
        }
    }

    qfile.close();
}
