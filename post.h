#ifndef POST_H
#define POST_H

#include <QDateTime>
#include <QUrl>
#include <QObject>

class Post
{
private:
    QString title;
    QDateTime date;
    QString content;
    QString reaction;
    quint16 weight;
    QList<QUrl> photos;

public:
    Post(QString title, QDateTime date, QString content, QString reaction, quint16 weight, QList<QUrl> photos);
    QString getTitle() {return title;}
    QDateTime getDate() {return date;}
    QString getContent() {return content;}
    QString getReaction() {return reaction;}
    quint16 getWeight() {return weight;}
    QList<QUrl> getPhotos() {return photos;}

    void setTitle(QString t) {title = t;}
    void setDate(QDateTime d) {date = d;}
    void setContent(QString c) {content = c;}
    void setReaction(QString r) {reaction = r;}
    void setWeight(quint16 w) {weight = w;}
    void setPhotos(QList<QUrl> p) {photos = p;}
};

#endif // POST_H
