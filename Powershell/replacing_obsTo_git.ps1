# Получаем все .md файлы в текущем каталоге и подкаталогах
$mdFiles = Get-ChildItem -Filter *.md -Recurse

foreach ($file in $mdFiles) {
    # Читаем содержимое файла
    $content = Get-Content $file.FullName

    # Заменяем старый формат ссылок на изображения новым 
    $content = $content -replace '!\[\[Pasted image (\d+)\.png\]\]', '![](Standoff/image/$1.png)'

    # Записываем обновлённое содержимое обратно в файл
    Set-Content $file.FullName $content
}

# Получаем все PNG файлы в текущем каталоге и подкаталогах
$pngFiles = Get-ChildItem -Filter '*.png' -Recurse

foreach ($file in $pngFiles) {
    # Создаём новое имя, удаляя "Pasted image " из имени файла
    $newName = $file.Name -replace 'Pasted image ', ''

    # Объединяем с путём директории для создания полного нового пути
    $newPath = Join-Path -Path $file.DirectoryName -ChildPath $newName

    # Переименовываем файл, если новое имя отличается
    if ($newPath -ne $file.FullName) {
        Rename-Item -Path $file.FullName -NewName $newPath
    }
}

# Получаем все .ini файлы в текущем каталоге и подкаталогах
$iniFiles = Get-ChildItem -Path . -Filter *.ini -Recurse

foreach ($file in $iniFiles) {
    # Удаляем .ini файл
    Remove-Item -Path $file.FullName -Force
}
