#!/bin/bash

# Путь к исходному файлу темы
THEME_SRC="kit256.ini"

# Проверяем, установлен ли mc
if ! command -v mc &> /dev/null
then
    echo "❌ Midnight Commander не установлен. Установите его с помощью вашего пакетного менеджера."
    exit 1
fi

# Определяем пути для установки
USER_SKIN_DIR="$HOME/.local/share/mc/skins"
SYSTEM_SKIN_DIR="/usr/share/mc/skins"

# Запрашиваем у пользователя тип установки
echo "Выберите тип установки:"
echo "1) Пользовательская (в домашнюю папку)"
echo "2) Системная (требует sudo)"
read -p "Введите номер (1 или 2): " INSTALL_TYPE

case $INSTALL_TYPE in
    1)
        TARGET_DIR="$USER_SKIN_DIR"
        mkdir -p "$TARGET_DIR"
        cp "$THEME_SRC" "$TARGET_DIR/"
        echo "✅ Тема успешно установлена в $TARGET_DIR"
        ;;
    2)
        if [ "$(id -u)" -ne 0 ]; then
            echo "⚠️ Для системной установки требуется sudo."
            read -p "Продолжить с sudo? (y/n): " CONFIRM
            if [[ "$CONFIRM" != "y" ]]; then
                echo "❌ Установка отменена."
                exit 1
            fi
        fi
        TARGET_DIR="$SYSTEM_SKIN_DIR"
        sudo mkdir -p "$TARGET_DIR"
        sudo cp "$THEME/src" "$TARGET_DIR/"
        echo "✅ Тема успешно установлена в $TARGET_DIR"
        ;;
    *)
        echo "❌ Неверный выбор. Установка отменена."
        exit 1
        ;;
esac

echo ""
echo "🎉 Установка завершена!"
echo "Откройте Midnight Commander (mc), нажмите F9 → Options → Appearance и выберите 'kit256'."
