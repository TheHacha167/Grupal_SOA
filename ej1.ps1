# Solicitar al usuario que ingrese una nota
$nota = Read-Host "Por favor, introduce tu nota"

# Convertir la nota a un número decimal para la comparación
$notaDecimal = [decimal]$nota

# Determinar el rango de la nota y mostrar el mensaje correspondiente
if ($notaDecimal -ge 16.00 -and $notaDecimal -le 20.00) {
    Write-Host "Calificacion: Muy buena"
} elseif ($notaDecimal -ge 14.00 -and $notaDecimal -le 15.99) {
    Write-Host "Calificacion: Buena"
} elseif ($notaDecimal -ge 12.00 -and $notaDecimal -le 13.99) {
    Write-Host "Calificacion: Lo suficientemente buena"
} elseif ($notaDecimal -ge 10.00 -and $notaDecimal -le 11.99) {
    Write-Host "Calificacion: Media"
} else {
    Write-Host "Calificacion: Insuficiente"
}




