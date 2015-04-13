#lang racket
(define initEstado (lambda (n m) (list n m)))
(define contenidoN (lambda (estado) (first estado)))
(define contenidoM (lambda (estado) (second estado)))
(define N 4)
(define M 3)
(define P 2)
(define estadoInicial '(0 0))

;true si es estado final o false si no lo es
(define esEstadoFinal (lambda (estado) (
        if (= (contenidoN estado) P) #t #f               
        )))

;devuelve la solucion de una lista en caso de que la haya o una lista vacia
(define contieneSolucion (lambda (soluciones)(
         if (empty? soluciones) '()
            (
             if (esEstadoFinal (first soluciones))
                (first soluciones)
                (contieneSolucion (rest soluciones))
            )
         )))

;Operaciones de llenado
(define llenarN (lambda (estado) (
        if (< (contenidoN estado) N) (initEstado N (contenidoM estado)) '()
        )))
(define llenarM (lambda (estado)(
        if (< (contenidoM estado) M) (initEstado (contenidoN estado) M) '()
        )))
;operaciones de vaciado 
(define vaciarN (lambda (estado) (
        if (> (contenidoN estado) 0) (initEstado 0 (contenidoM estado)) '()                               
        )))
(define vaciarM (lambda (estado) (
        if (> (contenidoM estado) 0) (initEstado (contenidoN estado) 0) '()                             
        )))
;operaciones de vertdido
(define vertirNenM (lambda (estado) (
        if (> (contenidoN estado) 0) (
           if (< (contenidoM estado) M)(
              if (>= (- M (contenidoM estado)) (contenidoN estado))
                 (initEstado 0 (+ (contenidoN estado) (contenidoM estado)))
                 (initEstado (- (contenidoN estado) (- M (contenidoM estado))) M )
              ) '()
           ) '()                            
        )))
(define vertirMenN (lambda (estado) (
        if (> (contenidoM estado) 0) (
           if (< (contenidoN estado) N) (
               if (>= (- N (contenidoN estado)) (contenidoM estado))
                  (initEstado (+ (contenidoM estado) (contenidoN estado)) 0)
                  (initEstado N (- (contenidoM estado) (- N (contenidoN estado))))
              ) '()
           ) '()                             
        )))

;devuelve una lista de nodos reordenada en caso de que haya un nodo final
(define reordenar (lambda (sucesores) (
        remove '() (append (list (contieneSolucion sucesores)) (remove (contieneSolucion sucesores) sucesores))
        )))

;devuelve los sucesores de un cierto nodo comprobando si existe alguna solucion entre ellos 
(define getSucesores (lambda (estado) ( 
        reordenar (remove '() (remove-duplicates  (list (llenarN estado) (llenarM estado) (vaciarN estado) (vaciarM estado) (vertirNenM estado) (vertirMenN estado))))                    
        )))

;Devuelve los sucesores no repetidos
(define sucesores-norepetidos (lambda (repetidos sucesores) (   
        remove* repetidos sucesores
        )))

;método principal
(define jugar (lambda (actual sucesores abiertos cerrados camino) ( 
        if (esEstadoFinal actual) (append camino (list actual))
           (
            if (empty? sucesores) 
               (jugar (first abiertos) 
                      (sucesores-norepetidos (append (list actual) abiertos cerrados) (getSucesores (first abiertos))) 
                      (append (sucesores-norepetidos (append (list actual) abiertos cerrados) (getSucesores (first abiertos)))  (rest abiertos) )
                      (list* actual cerrados) 
                      camino
               )
               (jugar (first abiertos)
                      (sucesores-norepetidos (append (list actual) abiertos cerrados) (getSucesores (first abiertos)))
                      (append  (sucesores-norepetidos (append (list actual) abiertos cerrados) (getSucesores (first abiertos)))  (rest abiertos) )
                      (list* actual cerrados)
                      (append camino (list actual) )
               )
           )                                                      
        )))


