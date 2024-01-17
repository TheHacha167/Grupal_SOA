# Función para solicitar al usuario que introduzca un nombre de usuario
function SolicitarUsuario() {
    $usuario = Read-Host "Introduce el nombre de usuario"
    return $usuario
}

# Función para verificar si un usuario existe en el sistema Linux
# Utiliza el comando 'id' de Linux para verificar la existencia del usuario
function VerificarUsuario($usuario) {
    # Ejecuta el comando 'id' y captura tanto la salida como el estado de salida
    $output = bash -c "id $usuario 2>&1"
    $exitCode = $LASTEXITCODE

    # Verifica si el comando fue exitoso (código de salida 0)
    return $exitCode -eq 0
}

# Ejemplo de uso de las funciones
$usuario = SolicitarUsuario
$existeUsuario = VerificarUsuario $usuario

# Informa al usuario si el usuario solicitado existe o no
if ($existeUsuario) {
    Write-Host "El usuario $usuario existe."
} else {
    Write-Host "El usuario $usuario no existe."
}
