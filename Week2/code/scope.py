#using the global specification converted _a_global to a truly global variable
#that became available outside that function (overwriting the original _a_global).

_a_global = 10

print("Outside the function, the value of _a_global is", _a_global)

def a_function():
    global _a_global
    _a_global = 5
    _a_local = 4
    
    print("Inside the function, the value of _a_global is ", _a_global)
    print("Inside the function, the value _a_local is ", _a_local)
    
    return None

a_function()

print("Outside the function, the value of _a_global now is", _a_global)

# using the global keyword inside the inner function _a_function2 resulted in changing the 
#value of _a_global in the main worspace / namespace to 20, but within the scope of _a_function, remained 10!

def a_function():
    _a_global = 10

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function, value of _a_global is ", _a_global)

    _a_function2()
    
    print("After calling _a_function2, value of _a_global is ", _a_global)
    
    return None

a_function()

print("The value of a_global in main workspace / namespace is ", _a_global)

#because _a_global was defined in advance (outside the first function), it get modified when
#changes in the inner function (it does not exist as a local within the scope of _a_function, 
#but is “inherited” from the main scope / workspace / namespace)

_a_global = 10

def a_function():

    def _a_function2():
        global _a_global
        _a_global = 20
    
    print("Before calling a_function, value of _a_global is ", _a_global)

    _a_function2()
    
    print("After calling _a_function2, value of _a_global is ", _a_global)

a_function()

print("The value of a_global in main workspace / namespace is ", _a_global)