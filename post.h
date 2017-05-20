#ifndef POST_H
#define POST_H

#include <QDate>
#include <QUrl>

class Post
{
private:
    QString title;
    QString content;
    quint16 reaction;
    QList<QUrl> photos;

public:
    Post(QString title, QString content, quint16 reaction, QList<QUrl> photos);
    QString getTitle() {return title;}
    QString getContent() {return content;}
    quint16 getReaction() {return reaction;}
    QList<QUrl> getPhotos() {return photos;}

    void setTitle(QString t) {title = t;}
    void setContent(QString c) {content = c;}
    void setReaction(quint16 r) {reaction = r;}
    void setPhotos(QList<QUrl> p) {photos = p;}
};

#endif // POST_H
