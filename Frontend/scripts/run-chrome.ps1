# Usar Flutter instalado en el equipo (sin depender del PATH global).
$flutterBin = "d:\proyectos_programacion\flutter\bin"
if (-not (Test-Path "$flutterBin\flutter.bat")) {
    Write-Error "No se encontró Flutter en $flutterBin. Instala el SDK o ajusta la ruta en este script."
    exit 1
}
$env:Path = "$flutterBin;" + $env:Path
Set-Location "d:\proyectos_programacion\Redes2"
flutter pub get
flutter run -d chrome
