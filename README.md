# Calculadora-Bison

Elkin Benitez y Santiago Gonzales

Calculadora en bison

Realizamos una calculadora la cual funciona de manera correcta permitiendo el calculo de operaciones tanto simples como complejas, dando resultados correctos y dando confianza para su uso regular

Explicacion:

1. Tokenizacion:

El lexer divide la expresion matematica ingresada en simbolos, donde despues pasa a un análasis semantico donde valida que los simbolos sigan una estructura correcta dada por lo tokens,
si no mandara un mensaje de error de sintaxis

2. Analisis:
El analisis del funcionamiento comienza cuando se ingresa una operacion a la calculadora y esta convierte los caracteres en tokens, luego comienza a aplicar las reglas yyparse() las cuales empiezan a contruir el arbol sintactico, el arbol funciona de manera jerarquica lo cual emieza a contruir dando prioridad a las operaciones encerradas entre parentesis, luego empieza a realizar primero la suma y la resta, luego la division y multiplicacion. Donde cada nodo es una operacion y cada subnodo(hojas) son los operandos(numeros que componen la operacion inicial), y se desgloza o se contruye el arbol hasta que se llega a la solucion final.
El arbol de sintaxis se utiliza para evaluar la aexpresion, validando que cada componente se pueda convertir en un token y que estos se puedan operar de manera clara y transparente, realizando el calculo correcto

3. Evaluacion: Vamos a explicar como se evalua las expresiones mediante el arbol de sintaxis y como se produce el resultado final.

- Al ingresar la expresion, cada simbolo debe tener equivalencia con los tokens definidos en nuestro lenguaje
- Una vez que acepte la cadena y que cada simbolo se convierta en untoken que el programa puede leer, se le otorga su respectivo equivalencia, si es 3 es NUM, si es ( en LPAR, si es + es SUM y asi sucesivamente.
- Al identifica cada token, va armando el arbol teniendo en ceunta diferentes factores como lo son, la jerarquia de la operacion, los operadores y operandos
- Despues de construirlo, lee en orden descendiente, nodo y hojas, y va haceindo operacion por operacion hasta que se llega a un resultado final.


# Pasos para ejecutar el programa:

- se debe crear un archivo de texto con el comando nano y nombre del archivo .l para flex y .y para bison -> nano calculadora.l y nano calculadora.y
- luego generar archivo en c de bison con el  -> bison -d calculadora.y
- luego generar archivo en c de flex -> flex calculadora.l
- ahora para compilar los dos archivos C vamos a utilizar el sigueinte comando -> gcc -o calculadora calculadora.tab.c lex.yy.c -lfl -lm
- ahora ejecutamos la calculadora -> ./calculadora

y listo, quedó para utilizar 
