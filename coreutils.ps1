try {
 "Verificando si Git esta instalado..."
 git -v
} catch {
 "Git no instalado, instalando a traves de scoop..."
 try {
  scoop install git
  try {
    git -v
  } catch { 
    Write-Host "ERROR FATAL: No se pudo instalar git" -ForegroundColor red 
  }
 } catch { 
   "Scoop no instalado, instalando..."
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
   scoop install git
 }
}
scoop update
scoop bucket add extras
scoop bucket add games
function Show-Menu {
  param ([string]$Title = 'My Menu')
  cls
  Write-Host ""
  Write-Host "   _____                 _    _ _   _ _     " -ForegroundColor red
  Write-Host "  / ____|               | |  | | | (_) |    " -ForegroundColor red
  Write-Host " | |     ___  _ __ ___  | |  | | |_ _| |___ " -ForegroundColor red
  Write-Host " | |    / _ \| '__/ _ \ | |  | | __| | / __|" -ForegroundColor red
  Write-Host " | |___| (_) | | |  __/ | |__| | |_| | \__ \" -ForegroundColor red
  Write-Host "  \_____\___/|_|  \___|  \____/ \__|_|_|___/" -ForegroundColor red
  Write-Host ""
  Write-Host "	  By Facundo Baynac"
  Write-Host "	  https://flbaynac.com.ar"
  Write-Host ""
  Write-Host "================ $Title ================"
    
  Write-Host "1: Press '1' for this option."
  Write-Host "2: Press '2' for this option."
  Write-Host "3: Borrar todos los programas instalados a traves de CoreUtils"
  Write-Host " Esto desinstalara Scoop y borrara la carpeta C:\users\usuario\scoop" -ForegroundColor red
  Write-Host ""
  Write-Host "q: Seleccione 'q' para salir."
} 
do {
  Show-Menu
  $input = Read-Host "Su eleccion "
  switch ($input) {
      '1' {
      cls
      "You chose option #1"
      pause
      } '2' {
      cls
      "You chose option #2"
      pause
      } '3' {
      "Desinstalando Scoop..."
      scoop uninstall scoop
      "Por favor remueva manualmente la carpeta C:\Users\su_usuario\scoop"
      pause
      } 'q' {
      return
      }
  }
}
until ($input -eq 'q')