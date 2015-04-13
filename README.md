# PECL1_IA
Implementación del problema de las jarras en Racket

Se dispone de dos recipientes no graduados con capacidades de m ý n litros respectivamente, siendo  n  ý  m  naturales primos entre sí y cumpliendo  m<n. Se quiere llegar a tener una cantidad p contenida en la primera de ellas, con  p< m + n.

M, N, P y el estado inicial están definidos en el programa. 

Ejemplo de ejecución inicial:

(jugar estadoInicial (getSucesores estadoInicial) (getSucesores estadoInicial) '() '())

