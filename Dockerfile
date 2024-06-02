# Используем официальный образ OpenJDK как базовый
FROM bellsoft/liberica-openjdk-alpine:17

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем исполняемый JAR-файл приложения в контейнер
COPY ./target/devops-practices*.jar /app.jar

EXPOSE 8181

# Указываем команду запуска приложения
ENTRYPOINT ["java", "-jar" ,"app.jar"]
