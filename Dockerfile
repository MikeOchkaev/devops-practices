# Используем официальный образ OpenJDK как базовый
FROM bellsoft/liberica-openjdk-alpine:17

# Устанавливаем рабочую директорию в контейнере
WORKDIR /opt/app

# Копируем исполняемый JAR-файл приложения в контейнер
COPY ./target/devops-practices-*.jar devops-practices.jar

EXPOSE 8080

# Указываем команду запуска приложения
ENTRYPOINT ["java", "-jar" ,"devops-practices.jar"]
