### Using C++ and Matlab

1. [Install Matlab](https://de.mathworks.com/downloads/web_downloads?s_tid=srchtitle)

2. If you want to develop in VS jump to 3
    
    2.1 If you like the Matlab Editor, just create a new file in the current folder and `mexmain.cpp`.

    2.2 Copy the following into your `cpp` file:
```c++
    #include <iostream>
    #include "mex.h"
     
    /*
     * Our custom function
     */
    void f() {
        static int i;
        mexPrintf("Hello World from C++ for the %i'th time!\n", i++);
    }
    
    /* The gateway function
     * This is needed for matlab to reference the defining function
     *
     * - nlhs ~ left-hand-side  (outputs)
     * - nrhs ~ right-hand-side (inputs)
     */ 
    void mexFunction(int nlhs, mxArray* plhs[],
                     int nrhs, const mxArray* prhs[]) {
        f();
    }
```

    2.3 You need the `mexFunction(...)` with exactly this signature, to being able to interact with every possible MATLAB function

    2.4 The name of your function is defined as the name of your file without the extention, e.g `mexmain`

    2.5 To compile this library, type this in the console:
```matlab
    >> mex mexmain.cpp
    Building with 'MinGW64 Compiler (C++)'.
    MEX completed successfully.
```

    2.6 To run the function, type:
```matlab
    >> mexmain()
    Hello World from C++ for the 0'th time!
```
  
    2.7 You can use Header the same way you are used to. Create this file in the same directory with the name `node.hpp`
```c++
    #include "mex.h"
    
    #include <iostream>
    #include <algorithm>
    
    class Node {
    
    public:
        Node()
        : b(false)
        , i(10) 
        {
            mexPrintf("Init constructor got called");
        }
        
        ~Node(){
            mexPrintf("Destructor got called");
        }
        
        Node (const Node & other) {
            this->b = other.b;
            this->i = other.i;
            mexPrintf("Copy got called");
        }
        
        void print(){
            
            mexPrintf("Bool  b: %s\n", b ? "true" : "false");
            mexPrintf("Int   i: %i\n", i);
            mexPrintf("Double f: %.2f\n", f);
            mexPrintf("Vector vf: [ ");
            std::for_each(vf.begin(), vf.end(), [&](double & f){
                mexPrintf("%f ", f);
            });
            mexPrintf("]\n");
        }
       
    private:
        bool b;
        int i = 0;
        double f = 1.123;
        std::string s = "Hello from node!\n";
        std::vector<double> vf = { 1.0, 2.3, 4.5 };
        
    };
```
    And the new `mexmain.cpp`:
```c++
    #include <iostream>
    #include "mex.h"
    #include "node.hpp"

    /*
     * Our custom function
     */
    void f() {
        static int i;
        mexPrintf("Hello World from C++ for the %i'th time!\n", i++);
    }
    
    /* The gateway function
     * This is needed for matlab to reference the defining function
     *
     * - nlhs ~ left-hand-side  (outputs)
     * - nrhs ~ right-hand-side (inputs)
     */ 
    void mexFunction(int nlhs, mxArray* plhs[],
                     int nrhs, const mxArray* prhs[]) {
        f();
        Node n();
        n.print();
        f();
    }
```
    If you run, this should be the output:
```matlab
    >> mexmain()
    Hello World from C++ for the 0'th time!
    Init constructor got calledBool  b: false
    Int   i: 10
    Double f: 1.12
    Vector vf: [ 1.000000 2.300000 4.500000 ]
    Hello World from C++ for the 1'th time!
    Destructor got called
```

    2.8 You probably have at least `C++14`, but look it up by yourself (test some features)

3. Download your preferred Visual Studio (tested with VS 2017 Community) from your university MSDNN account.

    3.1 Pick all C++ Development options (Win8.1 SDK C++ e.t.c)

    3.1.1 You can update your VS with the VS Installer in 2017. Click on the Customize Icon in the top-left and pick your options

    3.1.2 Updates with <= VS2015 should be configurable through the `vs.exe` -> Right Click -> Customize.

    3.2 Because the SO answer just werks™:
```text
    Create an empty project in VS

    Configuration properties -> General:
        Set Target Extension to .mexw64
        Set Configuration Type to Dynamic Library (.dll)

    Configuration poperties -> VC++ Directories:
        Add $(MATLAB_ROOT)\extern\include; to Include Directories

    Configuration properties -> VC++ -> General:
        Add $(MATLAB_ROOT)\extern\lib\win64\microsoft; to Library Directories

    Configuration properties -> Linker -> Input:
        Add libmx.lib;libmex.lib;libmat.lib; to Additional Dependencies

    Configuration properties -> Linker -> Command Line:
        Add /export:mexFunction to Additional Options

    $(MATLAB_ROOT) is the path to Matlab's root folder, eg. C:\Program Files\MATLAB\R2017a.
```

    3.3 Copy the files from step 2.7 into your created project with their respective names

    3.4 Build it without errors (Shortcut should be F7 in VS2017)

    3.5 Now you can navigate with Matlab to the directory `$(PROJECT)/Solution/Project/x64/Debug` and there should be a `.mexw64` file. Now the function is callable from Matlab with the name of the file as described in 2.6. You can move the `.mexw64` file without problems.