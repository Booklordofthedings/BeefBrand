# BeefBrand
This program generates .bf files that contain a hardcoded version of your assets.  
That way you can make sure that important files will be distributed with the .exe.

## Usage
You have to Compile the project and run the .exe with
a path argument. "--path D:\Path\ToThe\Directory".
It will then follow up by creating that .bf file.
You can also use the "--out D:\Path\ToThe\Directory"
argument to specify the output path.

If you want a different word lenght you can add a .bytefactor after the file name and
before the file ending.

File.8.png  
1 = 8bytes = uint8 (default)  
2 = 16bytes = uint16  
4 = 32bytes = uint32  
8 = 64bytes = uint64  

