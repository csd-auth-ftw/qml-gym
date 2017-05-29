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
    quint16 calories;
    bool run;
    QList<QUrl> photos;

public:
    Post(QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos);
    QString getTitle() {return title;}
    QDateTime getDate() {return date;}
    QString getContent() {return content;}
    QString getReaction() {return reaction;}
    quint16 getWeight() {return weight;}
    quint16 getCalories() {return calories;}
    bool getRun() {return run;}
    QList<QUrl> getPhotos() {return photos;}

    void setTitle(QString t) {title = t;}
    void setDate(QDateTime d) {date = d;}
    void setContent(QString c) {content = c;}
    void setReaction(QString r) {reaction = r;}
    void setWeight(quint16 w) {weight = w;}
    void setCalories(quint16 c) {calories = c;}
    void setRun(bool r) {run = r;}
    void setPhotos(QList<QUrl> p) {photos = p;}
};

#endif // POST_H
