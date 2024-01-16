# Función para pedir al usuario que introduzca un nombre de usuario
function SolicitarUsuario() {
    $usuario = Read-Host "Introduce el nombre de usuario"
    return $usuario
}

# Función para verificar si un usuario existe en el sistema Linux
# Utiliza el comando 'id' de Linux para verificar la existencia del usuario
function VerificarUsuario($usuario) {
    try {
        # Ejecuta el comando 'id' y captura el resultado
        $output = bash -c "id $usuario"
        # Si el comando se ejecuta sin errores, el usuario existe
        return $true
    } catch {
        # Si ocurre un error (excepción), asumimos que el usuario no existe
        return $false
    }
}

# Ejemplo de uso de las funciones
$usuario = SolicitarUsuario
$existeUsuario = VerificarUsuario $usuario

# Informar al usuario si el usuario solicitado existe o no
if ($existeUsuario) {
    Write-Host "El usuario $usuario existe."
} else {
    Write-Host "El usuario $usuario no existe."
}
