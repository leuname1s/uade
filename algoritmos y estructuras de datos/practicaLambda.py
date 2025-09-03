import random

# ---- punto 1 ----
def punto1():
    superficie = lambda largo, ancho: largo * ancho
    aprobado = lambda nota: nota >= 4
    cambiar_signo = lambda x: x * -1
    nombre_largo = lambda nombre: len(nombre) > 10
    positivo_o_cero = lambda x: x >= 0
    multiplicar = lambda a,b: a*b
    mayor_que = lambda a,b: a > b

    # Ejemplos de uso
    print(superficie(5,3))
    print(aprobado(5))
    print(cambiar_signo(-7))
    print(nombre_largo("Manuel Alejandro"))
    print(positivo_o_cero(-1))
    print(multiplicar(4,5))
    print(mayor_que(10,7))
  

    
    

punto1()
# punto2()
# punto3()
# punto4()
# punto5()
# punto6()
# punto7()
# punto8()
# punto9()