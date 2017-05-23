#include "post.h"

Post::Post(QString title, QDate date, QString content, quint16 reaction, QList<QUrl> photos)
{
    // initialize properties
    setTitle(title);
    setDate(date);
    setContent(content);
    setReaction(reaction);
    setPhotos(photos);
}
