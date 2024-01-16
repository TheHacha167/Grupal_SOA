while ($true) {
    # Mostrar el menú de opciones
    Write-Host "Seleccionar:"
    Write-Host "1 - Verificar la existencia de un usuario."
    Write-Host "2 - Conocer el UID de un usuario."
    Write-Host "q - Salir."
    $opcion = Read-Host "Por favor, elige una opcion"

    # Procesar la elección del usuario
    switch ($opcion) {
        "1" {
            $usuario = Read-Host "Introduce el nombre del usuario"
            if (Get-LocalUser -Name $usuario -ErrorAction SilentlyContinue) {
                Write-Host "El usuario $usuario existe."
            } else {
                Write-Host "El usuario $usuario no existe."
            }
        }
        "2" {
            $usuario = Read-Host "Introduce el nombre del usuario"
            try {
                $uid = (Get-LocalUser -Name $usuario).SID.Value
                Write-Host "El UID de $usuario es $uid"
            } catch {
                Write-Host "No se pudo encontrar el UID para $usuario"
            }
        }
        "q" {
            exit
        }
        default {
            Write-Host "Opcion no valida."
        }
    }
}