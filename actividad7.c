#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

int main(int argc, char *argv[]) {
    DIR *dir;
    struct dirent *entry;
    struct stat info;

    // Verificar si se han pasado los argumentos correctos
    if (argc != 3) {
        fprintf(stderr, "Uso: %s <directorio> <uid>\n", argv[0]);
        return 1;
    }

    // Convertir el ID de usuario a un número usando unsigned int en lugar de uid_t
    unsigned int uid = atoi(argv[2]);

    // Abrir el directorio
    dir = opendir(argv[1]);
    if (dir == NULL) {
        perror("opendir");
        return 1;
    }

    // Leer las entradas del directorio
    while ((entry = readdir(dir)) != NULL) {
        // Construir la ruta completa al archivo
        char path[1024];
        sprintf(path, "%s/%s", argv[1], entry->d_name);

        // Obtener información del archivo
        if (stat(path, &info) == -1) {
            perror("stat");
            continue;
        }

        // Comparar el UID del archivo con el UID proporcionado
        if ((unsigned int)info.st_uid == uid) {
            printf("%s\n", path);
        }
    }

    closedir(dir);
    return 0;
}
