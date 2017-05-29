#include "post.h"

Post::Post(QString title, QDateTime date, QString content, QString reaction, quint16 weight, quint16 calories, bool run, QList<QUrl> photos)
{
    // initialize properties
    setTitle(title);
    setDate(date);
    setContent(content);
    setReaction(reaction);
    setWeight(weight);
    setCalories(calories);
    setRun(run);
    setPhotos(photos);
}
