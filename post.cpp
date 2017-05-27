#include "post.h"

Post::Post(QString title, QDateTime date, QString content, QString reaction, quint16 weight, QList<QUrl> photos)
{
    // initialize properties
    setTitle(title);
    setDate(date);
    setContent(content);
    setReaction(reaction);
    setWeight(weight);
    setPhotos(photos);
}
