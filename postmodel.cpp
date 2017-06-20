#include "postmodel.h"

PostModel::PostModel(QString path)
{
    points = 0;
    modelFilePath = path;
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
    roles[WeightRole] = "weight";
    roles[CaloriesRole] = "calories";
    roles[RunRole] = "run";
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
        case WeightRole: return p.getWeight();
        case CaloriesRole: return p.getCalories();
        case RunRole: return p.getRun();
        case PhotosRole: return QVariant::fromValue(p.getPhotos());
        default: return QVariant();
    }
}

void PostModel::insertPost(QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos)
{
    beginResetModel();

    Post post(title, date, content, reaction, weight, calories, run, photos);
    postData.insert(postData.begin(), post);
//    postData.push_back(post);

    endResetModel();
}

void PostModel::editPost(int index, QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos)
{
    beginResetModel();
    
    int size = postData.size();
    if(index > -1 && index < size)
    {
        postData[index].setTitle(title);
        postData[index].setDate(date);
        postData[index].setContent(content);
        postData[index].setReaction(reaction);
        postData[index].setWeight(weight);
        postData[index].setCalories(calories);
        postData[index].setRun(run);
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

void PostModel::addPoints(int points)
{
    this->points += points;
}

void PostModel::loadModel()
{
    cout << "Loading post model..." << endl;

    QFile qfile(modelFilePath);
    QTextStream qtxstream(&qfile);
    qfile.open(QIODevice::ReadOnly | QIODevice::Text);

    points = qtxstream.readLine().toInt();
    int rows = qtxstream.readLine().toInt();
    for (int i=0; i<rows; i++)
    {
        QString title = qtxstream.readLine();
        QDateTime date = QDateTime::fromString(qtxstream.readLine(), "dd-MM-yyyy hh:mm");

        // reads the multi row content
        QString line, content;
        while (true) {
            line = qtxstream.readLine();
            if (line == END_OF_CONTENT)
                break;

            content.append(line + "\n");
        }

        QString reaction = qtxstream.readLine();
        quint16 weight = qtxstream.readLine().toInt();
        quint16 calories = qtxstream.readLine().toInt();
        bool run = qtxstream.readLine().toInt() > 0 ? true: false;

        int photos_n = qtxstream.readLine().toInt();
        std::cout << "photos_n=" << photos_n << std::endl;
        QList<QUrl> photos = QList<QUrl>();
        for (int j=0; j<photos_n; j++)
        {
            QUrl url(qtxstream.readLine());
            photos.append(url);
        }

        insertPost(title, date, content, reaction, weight, calories, run, photos);
    }

    qfile.close();
}

void PostModel::saveModel()
{
    cout << "Saving post model..." << endl;
    
    QFile qfile(modelFilePath);
    QTextStream qtxstream(&qfile);
    qfile.open(QIODevice::WriteOnly | QIODevice::Text);

    // write the number of points
    qtxstream << points << endl;

    // write the number of rows
    qtxstream << rowCount() << endl;

    // write each post data
    vector<Post>::reverse_iterator itr;
    for (itr = postData.rbegin(); itr != postData.rend(); itr++)
    {
        qtxstream << itr->getTitle().trimmed() << endl;
        qtxstream << itr->getDate().toString("dd-MM-yyyy hh:mm") << endl;
        qtxstream << itr->getContent().trimmed() << endl << END_OF_CONTENT << endl;
        qtxstream << itr->getReaction() << endl;
        qtxstream << itr->getWeight() << endl;
        qtxstream << itr->getCalories() << endl;
        qtxstream << (itr->getRun() ? 1: 0) << endl;

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
