Write-Host "                                            " -ForegroundColor red
Write-Host "   _____                 _    _ _   _ _     " -ForegroundColor red
Write-Host "  / ____|               | |  | | | (_) |    " -ForegroundColor red
Write-Host " | |     ___  _ __ ___  | |  | | |_ _| |___ " -ForegroundColor red
Write-Host " | |    / _ \| '__/ _ \ | |  | | __| | / __|" -ForegroundColor red
Write-Host " | |___| (_) | | |  __/ | |__| | |_| | \__ \" -ForegroundColor red
Write-Host "  \_____\___/|_|  \___|  \____/ \__|_|_|___/" -ForegroundColor red
Write-Host "                                            " -ForegroundColor red
"	By Facundo Baynac"
"	https://flbaynac.com.ar"
try {
 ""
 "Verificando si Git esta instalado..."
 git -v
} catch {
 "Git no instalado, instalando a través de scoop..."
 try {
  scoop install git
  } catch { 
    "Scoop no instalado, instalando..."
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
    scoop install git
  }
}
