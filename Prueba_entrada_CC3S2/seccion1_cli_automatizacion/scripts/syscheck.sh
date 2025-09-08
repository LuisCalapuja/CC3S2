#!/usr/bin/env bash
set -euo pipefail
trap 'echo "[ERROR] Falló en línea $LINENO" >&2' ERR

mkdir -p reports

# TODO: HTTP-guarda headers y explica código en 2-3 líneas al final del archivo
ESTADO=$(curl -Is https://example.com | head -n 1)  # Cogemos la primera linea de las cabeceras
CODIGO_HTTP=$(echo "$ESTADO" | awk '{print $2}') # Dividimos la linea en bloques e imprimimos el 2do que contiene el codigo http
{
  echo "curl -I example.com"
  curl -Is https://example.com | sed '/^\r$/d'
  echo 
  echo "Explicación Codigos de estado HTTP: 
  Código HTTP X significa ..."

  case "$CODIGO_HTTP" in 
    1*) echo "- Código $CODIGO_HTTP: Contiene respuesta informativa (1XX)."
        echo "- Indica que la solicitud ha sido recibida y el proceso está en curso."
        ;;
    2*) echo "- Código $CODIGO_HTTP: Contiene respuestas exitosas (2XX)."
        echo "- Indica que la solicitud fue exitosa y se pudo completar correctamente."
        ;;
    3*) echo "- Código $CODIGO_HTTP: Contiene respuesta de redirección (3XX)."
        echo "- Indica que se necesita realizar una acción adicional para completar la solicitud."
        ;;
    4*) echo "- Código $CODIGO_HTTP: Contiene respuestas de error del cliente (4XX)."
        echo "- Indica que hubo un error en la solicitud realizada por el cliente."
        ;;
    5*) echo "- Código $CODIGO_HTTP: Contiene respuestas de error del servidor (5XX)."
        echo "- Indica que hubo un error en el servidor al intentar procesar la solicitud del cliente."
        ;;
    *)  echo "- Código $CODIGO_HTTP: Categoria desconocida."
    ;;
    esac
} > reports/http.txt

# TODO: DNS — muestra A/AAAA/MX y comenta TTL
{
  # +noall suprime toda la salida de dig y +answer muestra la sección de respuesta (Nombre, TTL, clase, tipo, valor)
  echo "A";    dig A example.com +noall +answer
  echo "AAAA"; dig AAAA example.com +noall +answer
  echo "MX";   dig MX example.com +noall +answer
  echo
  echo "TTL (Time To Live), tiempo en que el registro DNS permanece dentro del caché de un servidor DNS "
  echo "TTL alto reduce la carga en los servidores, se carga desde el caché (mejor tiempo de respuesta). Los cambios no se propagan tan rapidamente, ideal para entornos estáticos. "
  echo "TTL bajo los cambios se propagan rapidamente, favorable para entornos dinamicos. Su carga es más lenta ya que no permanece dentro del caché mucho tiempo"
} > reports/dns.txt

# TODO: TLS - registra versión TLS
{
  echo "TLS via curl -Iv"
  # curl -Iv https://example.com 2>&1 | sed -n '1,20p' modificamos esta linea por...
  curl -Iv https://example.com 2>&1 | grep "SSL connection" | awk '{print $5}'
  echo
  echo "Cambiamos 'sed' ya que solo nos devuelve las primeras 20 linea, no necesariamente nos muestra la version TLS. Con 'grep' filtramos la linea que sí la contiene y awk nos permite imprimir solo el campo de version"
} > reports/tls.txt

# TODO: Puertos locales - lista y comenta riesgos
{
  echo "ss -tuln"
  ss -tuln || true
  echo
  echo "Riesgos: Puertos abiertos innecesarios nos exponen a ciberataques, ya que estos puertos exponen los datos relacionados con el servicio a posibles atacantes. Pueden intentar obtener acceso, ejecutar codigo e 
  interrumpir servicios que se llevan a cabo en estos puertos. "
} > reports/sockets.txt

echo "Reportes generados en ./reports"