# Esta funcion solicita al usuario que introduzca un nombre de usuario
function SolicitarUsuario() {
    $usuario = Read-Host "Introduce el nombre de usuario"
    return $usuario
}

# Esta funcion verifica si un usuario existe en el sistema
function VerificarUsuario($usuario) {
    # Obtener lista de usuarios locales y buscar el nombre de usuario proporcionado
    $existe = Get-LocalUser | Where-Object { $_.Name -eq $usuario } | Measure-Object
    # Devuelve verdadero si se encontro el usuario, falso de lo contrario
    return $existe.Count -gt 0
}

# Uso de las funciones
$usuario = SolicitarUsuario
$existeUsuario = VerificarUsuario $usuario

if ($existeUsuario) {
    Write-Host "El usuario $usuario existe."
} else {
    Write-Host "El usuario $usuario no existe."
}
