# Implementa la función summarize y el CLI.
# Requisitos:
# - summarize(nums) -> dict con claves: count, sum, avg
# - Valida que nums sea lista no vacía y elementos numéricos (acepta strings convertibles a float).
# - CLI: python -m app "1,2,3" imprime: sum=6.0 avg=2.0 count=3

def summarize(nums):  # TODO: tipado opcional
    # raise NotImplementedError("Implementa summarize según el enunciado")
    # Validacion: nums no vacia.
    if len(nums)==0:
        raise ValueError("Lista nums vacia")
    # Verificamos que sean elementos numericos o convertibles a float.
    try:
        nums_float=[float(element) for element in nums] # Almacenamos los valores float de nums en la lista 'nums_float'
    except Exception:
        raise ValueError("La lista contiene elementos no convertibles a float")

    # Calculamos las metricas solicitadas
    count = len(nums_float)
    suma = sum(nums_float)
    avg = suma/count

    # Devuelve dict con claves: count, sum, avg
    return {"count": count, "sum":round(suma,1), "avg":round(avg, 1)}



if __name__ == "__main__":
    import sys
    # raw = sys.argv[1] if len(sys.argv) > 1 else ""
    # items = [p.strip() for p in raw.split(",") if p.strip()]

    if len(sys.argv)<2: # La entrada tiene 2 argumentos, sys.argv[0]='script que esta corriendo' & sys.argv[1]='argumento 1'
        print("Debe ingresar: python -m app '1,2,3' o similar" )
        raise SystemExit(1)

    entrada = sys.argv[1]             # Captura la cadena de entrada "1,2,3"
    nums_entrada = entrada.split(",")   # Lo convierte a una lista ["1","2","3"]

    resultados = summarize(nums_entrada)

    print(f"sum={resultados['sum']} avg={resultados['avg']} count={resultados['count']}")
    # TODO: validar items y llamar summarize, luego imprimir el formato solicitado
    # print("TODO: implementar CLI (python -m app \"1,2,3\")")