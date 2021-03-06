#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "mediator.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    Mediator mediator;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("mediator", &mediator);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
