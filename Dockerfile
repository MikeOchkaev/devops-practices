# Используем официальный образ OpenJDK как базовый
FROM bellsoft/liberica-openjdk-alpine:17

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем исполняемый JAR-файл приложения в контейнер
COPY target/devops-practices.jar app.jar

# Устанавливаем переменные среды
ENV JAVA_OPTS=""

# Указываем команду запуска приложения
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]
