#include <stdio.h>
#include <dirent.h>
#include <sys/stat.h>

int main(int argc, char *argv[]) {
    // Verifica si se ha pasado un argumento (el directorio)
    if (argc < 2) {
        printf("Uso: %s <directorio>\n", argv[0]);
        return 1;
    }

    DIR *dir;
    struct dirent *entrada;
    struct stat estado;
    
    int archivos = 0, directorios = 0, ejecutables = 0;
    
    // Intenta abrir el directorio
    dir = opendir(argv[1]);
    if (dir == NULL) {
        perror("opendir");
        return 1;
    }

    // Itera sobre los elementos en el directorio
    while ((entrada = readdir(dir)) != NULL) {
        stat(entrada->d_name, &estado);

        // Cuenta los subdirectorios
        if (S_ISDIR(estado.st_mode)) {
            directorios++;
        }
        // Cuenta los archivos regulares y ejecutables
        else if (S_ISREG(estado.st_mode)) {
            archivos++;
            // Verifica si el archivo es ejecutable por el usuario
            if (estado.st_mode & S_IXUSR) {
                ejecutables++;
            }
        }
    }

    closedir(dir);

    // Imprime los resultados
    printf("Archivos estandar: %d\n", archivos);
    printf("Subdirectorios: %d\n", directorios);
    printf("Ejecutables: %d\n", ejecutables);

    return 0;
}
