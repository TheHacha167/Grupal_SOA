#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>
#include <time.h>

void listarArchivos(const char *ruta);

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s <ruta_del_directorio>\n", argv[0]);
        exit(EXIT_FAILURE);
    }

    const char *ruta = argv[1];
    listarArchivos(ruta);

    return 0;
}

void listarArchivos(const char *ruta) {
    DIR *dir;
    struct dirent *entrada;
    struct stat info;
    char rutaCompleta[PATH_MAX];

    // Abre el directorio
    if ((dir = opendir(ruta)) == NULL) {
        perror("Error al abrir el directorio");
        exit(EXIT_FAILURE);
    }

    // Lee cada entrada del directorio
    while ((entrada = readdir(dir)) != NULL) {
        // Ignora las entradas de directorios y "." y ".."
        if (entrada->d_type == DT_DIR || strcmp(entrada->d_name, ".") == 0 || strcmp(entrada->d_name, "..") == 0) {
            continue;
        }

        // Construye la ruta completa del archivo
        snprintf(rutaCompleta, sizeof(rutaCompleta), "%s/%s", ruta, entrada->d_name);

        // Obtiene la información del archivo
        if (stat(rutaCompleta, &info) == -1) {
            perror("Error al obtener la información del archivo");
            closedir(dir);
            exit(EXIT_FAILURE);
        }

        // Convierte la fecha de la última modificación a una cadena de caracteres
        char fechaModificacion[20];
        strftime(fechaModificacion, sizeof(fechaModificacion), "%Y-%m-%d %H:%M:%S", localtime(&info.st_mtime));

        // Imprime el nombre, tamaño y fecha de la última modificación
        printf("Nombre: %s, Tamaño: %ld bytes, Última modificación: %s\n",
               entrada->d_name, (long)info.st_size, fechaModificacion);
    }

    // Cierra el directorio
    closedir(dir);
}
