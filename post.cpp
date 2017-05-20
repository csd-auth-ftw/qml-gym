#include "post.h"

Post::Post(QString title, QString content, quint16 reaction, QList<QUrl> photos)
{
    // initialize properties
    setTitle(title);
    setContent(content);
    setReaction(reaction);
    setPhotos(photos);
}
