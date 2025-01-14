### Historia de Usuario 1: Inicio del Juego
- **Escenario 1: Iniciar una nueva partida** 

    Given que el jugador ha iniciado la aplicación  
    When el jugador elige iniciar una nueva partida  
    Then la cuadrícula debe estar vacía y debe tener un tamaño de 3x3  
    And el jugador debe poder elegir entre jugar como "X" o "O"  
    And el turno actual debe mostrar "X" o "O"  

### Historia de Usuario 2: Realizar un Movimiento  
- **Escenario 2: Hacer un movimiento**  

    Given que el jugador ha iniciado el juego  
    And el turno actual es "X"  
    When el jugador hace clic en una casilla vacía  
    Then la casilla debe mostrar la marca "X"  
    And el turno debe cambiar al siguiente jugador, "O"  


- **Escenario 3: Movimiento en una casilla ya ocupada**  

    Given que el jugador ha iniciado el juego  
    And la casilla (1,1) tiene la marca "X"  
    When el jugador hace clic en la casilla (1,1)  
    Then no debe ocurrir ningún cambio y debe mostrarse un mensaje de error indicando que la casilla está ocupada  

### Historia de Usuario 3: Determinación de Ganador
- **Escenario 4: Determinar un ganador**  

    Given que el jugador ha realizado al menos dos movimientos  
    And las marcas del jugador están en la misma fila, columna o diagonal  
    When el jugador realiza el siguiente movimiento en la casilla vacía para completar 3 marcas consecutivas en esa fila, columna o diagonal  
    Then el juego debe declarar al jugador "X" como ganador  

- **Escenario 5: Empate**  

    Given que el jugador ha realizado movimientos alternos y todas las casillas están llenas  
    And no hay tres marcas consecutivas del mismo jugador en ninguna fila, columna o diagonal  
    When el jugador realiza el último movimiento y todas las casillas están ocupadas  
    Then el juego debe declarar un empate  

### Historia de Usuario 4: Reiniciar el Juego
- **Escenario 6: Reiniciar el juego** 

    Given que el jugador ha iniciado el juego  
    When el jugador hace clic en el botón de reiniciar  
    Then la cuadrícula debe restablecerse a un estado vacío  
    And el jugador debe poder seleccionar nuevamente si quiere jugar como "X" o "O"  
    And el turno debe ser "X" o "O"  


### Historia de Usuario 5: Interfaz de Usuario (UI) Intuitiva
- **Escenario 7: Ver interfaz intuitiva**  

    Given que el jugador ha abierto la aplicación  
    When visualiza la cuadrícula de Tic-Tac-Toe  
    Then la cuadrícula debe ser claramente visible y con un diseño limpio  
    And las casillas deben ser fácilmente seleccionables  
    And el estado del juego (turno actual, victoria, empate) debe estar claramente visible  


### Historia de Usuario 6: Modo de Juego Multijugador Local
- **Escenario 8: Jugar con otro jugador en el mismo dispositivo**  

    Given que el jugador ha seleccionado el modo de juego multijugador local  
    When ambos jugadores hacen clic en las casillas para colocar sus marcas  
    Then la cuadrícula debe mostrar correctamente las marcas de "X" y "O"  
    And el turno debe alternarse entre los jugadores después de cada movimiento  
    And el marcador debe mostrar el estado del juego para ambos jugadores  

### Historia de Usuario 7: Modo de Juego contra la Computadora (IA)
- **Escenario 9: Jugar contra la IA**  

    Given que el jugador ha seleccionado jugar contra la computadora (IA)  
    And ha seleccionado una dificultad de la IA configurable entre "fácil", "medio" o "difícil"  
    When el jugador hace un movimiento  
    Then la IA debe realizar un movimiento válido en la cuadrícula  