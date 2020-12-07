'''def makeabug(x):
    y = x**4
    z = 0.
    y = y/z
    return y

makeabug(25) '''

def buggyfunc(x)
    y = x
    for i in range(x):
        y = y-1
        z = x/y
    return z
    
buggyfunc(18) #by the 20th iteration y will be 0 and you cannot divide by 0

#sometimes code cannot be debugged
def buggyfunc(x):
    y = x
    for i in range(x):
        try: 
            y = y-1
            z = x/y
        except:
            print(f"This didn't work; x = {x}; y = {y}")
    return z

buggyfunc(20)

def buggyfunc(x):
    y = x
    for i in range(x):
        try: 
            y = y-1
            z = x/y
        except ZeroDivisionError: #python recognises this error
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work; x = {x}; y = {y}")
        else:
            print(f"OK; x = {x}; y = {y}, z = {z};")
    return z

buggyfunc(20)