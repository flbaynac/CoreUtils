# Instalar  y verificar dependencias
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

# Definir funciones interfaz
function Draw-Menu {
	[CmdletBinding()]
    param (
        [Parameter()]
        [String[]]
        $menuItems,
        [Parameter()]
        [int32]
        $menuPosition,
        [Parameter()]
        [String]
        $menuTitle,
        [Parameter()]
        [System.Object]
        $object,
        [Parameter()]
        [String]
        $secondaryKey = 'Description'
    )

    $menuLength = $menuItems.length
    $consoleWidth = $host.ui.RawUI.WindowSize.Width
    $foregroundColor = $host.UI.RawUI.ForegroundColor
    $backgroundColor = $host.UI.RawUI.BackgroundColor
    $leftTitlePadding = ($consoleWidth - $menuTitle.Length) / 2
    $titlePaddingString = ' ' * ([Math]::Max(0, $leftTitlePadding))
    $leftDescriptionPadding = ($consoleWidth - $secondaryKey.Length) / 2
	$descriptionPaddingString = ' ' * ([Math]::Max(0, $leftDescriptionPadding))

    Clear-Host
    Write-Host ""
    Write-Host "`t   _____                 _    _ _   _ _     " -ForegroundColor green
    Write-Host "`t  / ____|               | |  | | | (_) |    " -ForegroundColor green
    Write-Host "`t | |     ___  _ __ ___  | |  | | |_ _| |___ " -ForegroundColor green
    Write-Host "`t | |    / _ \| '__/ _ \ | |  | | __| | / __|" -ForegroundColor green
    Write-Host "`t | |___| (_) | | |  __/ | |__| | |_| | \__ \" -ForegroundColor yellow
    Write-Host "`t  \_____\___/|_|  \___|  \____/ \__|_|_|___/" -ForegroundColor yellow
    Write-Host ""
    Write-Host "`t`tBy Facundo Baynac"
    Write-Host "`t`thttps://flbaynac.com.ar"
    Write-Host ""
    Write-Host $('-' * $consoleWidth -join '')
    Write-Host ($titlePaddingString)($menuTitle)
    Write-Host $('-' * $consoleWidth -join '')

    $currentDescription = ""

    for ($i = 0; $i -lt $menuLength; $i++) {
        Write-Host "`t" -NoNewLine
        if ($i -eq $menuPosition) {
            Write-Host "$($menuItems[$i])" -ForegroundColor $backgroundColor -BackgroundColor $foregroundColor
            $currentItem = $menuItems[$i]
            $currentDescription = ($object | Where-Object { $_.Name -eq $currentItem }).Value.Description
        } else {
            Write-Host "$($menuItems[$i])" -ForegroundColor $foregroundColor -BackgroundColor $backgroundColor
        }
    }

    Write-Host $('-' * $consoleWidth -join '')
    Write-Host ($descriptionPaddingString)($secondaryKey)
    Write-Host $('-' * $consoleWidth -join '')
    # Display the description after the menu is rendered.
    Write-Host "`t$currentDescription"
}

function Menu {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String[]]
        $menuItems,
        [Parameter()]
        [String]
        $menuTitle = "Menu",
        [Parameter()]
        [System.Object]
        $object
    )
    $keycode = 0
    $pos = 0
    
    while ($keycode -ne 13) {
        Draw-Menu $menuItems $pos $menuTitle $object
        $press = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown")
        $keycode = $press.virtualkeycode
        if ($keycode -eq 38) {
            $pos--
        }
        if ($keycode -eq 40) {
            $pos++
        }
        if ($pos -lt 0) {
            $pos = ($menuItems.length - 1)
        }
        if ($pos -ge $menuItems.length) {
            $pos = 0
        }
    }
    return $($menuItems[$pos])
}

function mini-u {
    $MainMenu = (Invoke-webrequest -URI https://raw.githubusercontent.com/flbaynac/CoreUtils/main/menu.json | ConvertFrom-Json).PSObject.Properties
# Para testear localmente comentar la linea de arriba y descomentar la de abajo
#   $MainMenu = (Get-Content .\menu.json | ConvertFrom-Json).PSObject.Properties
    $MainMenuSelection = Menu $MainMenu.Name "Main Menu" $MainMenu ; Clear-Host
    $SubMenuOptions = $MainMenu | Where-Object{
        $_.Name -eq $MainMenuSelection
    }
    $SubMenu = ($SubMenuOptions.Value | %{$_.PSObject.Properties | ?{$_.Name -ne 'Description'}})
    $MenuOptionSelection = Menu $SubMenu.Name "Selecione una opcion del sub-menu" $SubMenu
    return $MenuOptionSelection
}

# Lanza interfaz y selecciona accion usuario
switch -Exact (mini-u) {
  "Backup_Users" {"backapeando usuarios..."}
}