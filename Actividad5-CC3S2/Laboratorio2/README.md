# Actividad 5

## Construir
### Ejercicios
1. Help imprime la siguiente salida, que son los targets y su respectiva descripcion (Que se muestra en comentario `##` en el Makefile)
```bash
  all           Construir, testear y empaquetar todo
  build         Generar out/hello.txt
  clean         Limpiar archivos generados
  help          Mostrar ayuda
```
La linea `.DEFAULT_GOAL := help` nos indica que si no pasamos argumento luego de escribir `make`, este tendra el valor por defecto `help`, es decir se ejecutara como `make help`.

La utilidad de declarar `PHONY` es que de haber archivos con el mismo nombre que `all`, `build`, `clean` o `help`; estos no se ejecuten, asi evitamos conflictos.

2. Comprobacion de generacion de idempotencia de `build`.

Primer comando `make build | tee logs/build-run1.txt`, salida:
```bash
mkdir -p out
python3 src/hello.py > out/hello.txt
```
Se crea el directorio `out/` o si esta creado no hace nada y al ejecutar `src/hello.py` se crea el archivo `hello.txt` dentro de `out/`. 

Segundo comando `make build | tee logs/build-run2.txt`, nos da la salida:
```bash
make: Nothing to be done for 'build'.
```
Esto sucede gracias a la siguiente linea dentro de `$(OUT_DIR)/hello.txt: $(SRC_DIR)/hello.py` que nos indica "`hello.txt` depende de `hello.py`", el grafo de dependencia es un diagrama interno de make donde se establece este concepto usando el comando inicial. El timestamp de un archivo marca la fecha/hora de su ultima modificacion, por lo tanto se hace una comparacion entre el timestamp de `hello.txt` y `hello.py`, si `hello.py` fue modificado desde de la creacion de su dependencia, entonces `make build` se ejecutará, caso contrario no se ejecutará nada.

3. Fallo controlado, usamos un interprete inexistente `PYTHON4`, y observamos:
```bash
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ PYTHON=python4 make build ; echo "exit=$?" | tee logs/fallo-python4.txt || echo "falló (esperado)"
mkdir -p out
python4 src/hello.py > out/hello.txt
bash: line 1: python4: command not found
make: *** [Makefile:32: out/hello.txt] Error 127
make: *** Deleting file 'out/hello.txt'
exit=2
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ ls -l out/hello.txt | tee -a logs/fallo-python4.txt || echo "no existe (correcto)"
ls: cannot access 'out/hello.txt': No such file or directory
```
Como podemos ver, python4 no es reconocido, al tratar de ejecutar la creacion de hello.txt falla, y como usamos la receta `ser -euo pipefail` todo el script falla, por lo que se crea un archivo vacio y da Error 127. Aqui es donde entra `.DELETE_ON_ERROR` que eliminar este archivo, evitando archivos vacios o corruptos. 

4. Ensayo dry-run
- `make -n build` nos muestra los comando que usaria `build` sin ejecutarlos, si el target esta al dia.
- El siguiente comando nos da una evaluacion de la ejecucion de `build`, nos da la siguiente salida:
```bash
onsidering target file 'build'.
 File 'build' does not exist.
  Considering target file 'out/hello.txt'.
   File 'out/hello.txt' does not exist.
    Considering target file 'src/hello.py'.
     Looking for an implicit rule for 'src/hello.py'.
     No implicit rule found for 'src/hello.py'.
     Finished prerequisites of target file 'src/hello.py'.
    No need to remake target 'src/hello.py'.
```
El "No need to remake target" nos indica el hello.py no ha sido modificado, por lo tanto no se hace nada.

- El siguiente comando nos muestra la linea donde se evalua el target file `out/hello.txt`
```bash
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ grep -n "Considering target file 'out/hello.txt'" logs/make-d.txt
18:  Considering target file 'out/hello.txt'.
```

5. Por qué cambiar la fuente obliga a rehacer, mientras que tocar el target no forja trabajo extra.
- Esto se debe a que `hello.txt` es dependiente de la ultima modificacion de `hello.py`, no al reves. Esto se define en el cuerpo de `make build` con el siguiente comando:
```bash
$(OUT_DIR)/hello.txt: $(SRC_DIR)/hello.py   # hello.txt depende de hello.py
```

6. Verificacion de estilo/formatos:
  - El primero comando tiene la salida `shellcheck no instalado`, lo cual nos indica la ausencia de la herramienta `shellcheck`(herramienta para el analisis estatico de scripts en bash), por lo tanto se adjunta los comandos para instalarla en WSL Ubuntu:
  ```bash
  sudo apt update
  sudo apt install -y shellcheck
  ```
  - El segundo comando nos muestra `shfmt no instalado` que es un formateador automatico de scripts bash. Para instalarlo seguimos los siguientes comandos en WSL Ubuntu:
  ```bash
  sudo apt update
  sudo apt install -y shfmt
  ```

  7. Paquete reproducible.
  - La primera parte nos entrega el siguiente hash: `07cbc79db756d10f55cbdc931d82d0877b2b7cb93694c74c0cddc884f337ab63`
  ```bash
  luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ mkdir -p dist
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ tar --sort=name --mtime='@0' --owner=0 --group=0 --numeric-owner -cf dist/app.tar src/hello.py
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ gzip -n -9 -c dist/app.tar > dist/app.tar.gz
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ sha256sum dist/app.tar.gz | tee logs/sha256-1.txt
07cbc79db756d10f55cbdc931d82d0877b2b7cb93694c74c0cddc884f337ab63  dist/app.tar.gz
  ```
  - La segunda parte, nos entrega el siguiente hash `07cbc79db756d10f55cbdc931d82d0877b2b7cb93694c74c0cddc884f337ab63` el cual es el mismo hash, nos da idempotencia.
  ```bash
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ rm -f dist/app.tar.gz
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ tar --sort=name --mtime='@0' --owner=0 --group=0 --numeric-owner -cf dist/app.tar src/hello.py
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ gzip -n -9 -c dist/app.tar > dist/app.tar.gz
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ sha256sum dist/app.tar.gz | tee logs/sha256-2.txt
07cbc79db756d10f55cbdc931d82d0877b2b7cb93694c74c0cddc884f337ab63  dist/app.tar.gz
  ```

- Conclusiones:
  - `tar --sort=name` fija un orden alfabetico para los archivos dentro de tar.
  - `--mtima='@0'` se fuerza la misma marca de tiempo para todos los miembros.
  - `--owner=0 --group=0 --numeric-owner` fija UID/GID constantes, asi el tar de depende de los usuarios.
  - `gzip -n` desactiva el guardado del nombre original y timestamp, asi al empaquetar sus hash son iguales.

  8. Missing separator. Reemplazamos TAB por espacios en la linea 31 de Makefile_bad. Esto produce el erro.

```bash
  luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ cp Makefile Makefile_bad
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ make -f Makefile_bad build |& tee evidencia/missing-separator.txt || echo "error reproducido (correcto)"
Makefile_bad:31: *** missing separator.  Stop.
```
- Diagnóstico rápido: `cat -A -n Makefile_bad` para ver `^I` (TAB) vs espacios y detectar `^M` (CRLF). También: `grep -n $'^\t' Makefile_bad` para listar líneas que sí empiezan con TAB.

### 1.3 Crear un script Bash
1. Primera salida:
```bash
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ ./scripts/run_tests.sh
Demostrando pipefail:
Sin pipefail: el pipe se considera exitoso (status 0).
Con pipefail: se detecta el fallo (status != 0).
Test pasó: Hello, World!
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ echo $?
0
```
2. Se modifica `hello.py` se ejecuta el `run_test.sh` nos da error:
```bash
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ ./scripts/run_tests.sh
Demostrando pipefail:
Sin pipefail: el pipe se considera exitoso (status 0).
Con pipefail: se detecta el fallo (status != 0).
Test falló: salida inesperada
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ echo $?
2
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ ls -l src/hello.py.bak || echo "OK: no existe .bak"
ls: cannot access 'src/hello.py.bak': No such file or directory
OK: no existe .bak
```
3. Trazado con bash -x
```bash
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ bash -x scripts/run_tests.sh | tee logs/trace-run_tests.txt
+ set -euo pipefail
+ IFS='
        '
+ umask 027
+ set -o noclobber
+ PY=python3
+ SRC_DIR=src
++ mktemp
+ tmp=/tmp/tmp.bJRM58MPv0
+ trap 'cleanup $?' EXIT INT TERM
+ echo 'Demostrando pipefail:'
+ set +o pipefail
Demostrando pipefail:
+ false
+ true
+ echo 'Sin pipefail: el pipe se considera exitoso (status 0).'
Sin pipefail: el pipe se considera exitoso (status 0).
+ set -o pipefail
+ false
+ true
+ echo 'Con pipefail: se detecta el fallo (status != 0).'
Con pipefail: se detecta el fallo (status != 0).
+ cat
+ check_deps
+ deps=('python3' 'grep')
+ local -a deps
+ for dep in "${deps[@]}"
+ command -v python3
+ for dep in "${deps[@]}"
+ command -v grep
+ run_tests src/hello.py
+ local script=src/hello.py
+ local output
++ python3 src/hello.py
+ output='Hello, Mundo!'
+ echo 'Hello, Mundo!'
+ grep -Fq 'Hello, World!'
+ echo 'Test falló: salida inesperada'
Test falló: salida inesperada
+ mv -- src/hello.py src/hello.py.bak
+ exit 2
+ cleanup 2
+ rc=2
+ rm -f /tmp/tmp.bJRM58MPv0
+ '[' -f src/hello.py.bak ']'
+ mv -- src/hello.py.bak src/hello.py
+ exit 2
luis@LAPTOP-LC:/mnt/c/Users/Luis/Documents/CC3S2/Actividad5-CC3S2/Laboratorio2$ echo $?
0
```