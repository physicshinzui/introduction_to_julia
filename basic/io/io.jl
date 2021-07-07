# IO tutorial in Julia
# Written by Shinji Iida
# Date : 5.7.2021

#=
## How to write a string in a file.
open("myfile.txt", "w") do io
    write(io, "Hello World")
end

## How to read the file. 
open(f->read(f, String), "myfile.txt")

rm("myfile")

open("multiline.txt", "w") do io
    for i in 1:10
        write(io, "$i \n")
    end
end
=#


io = open("multiline.txt", "r")
stringvec= rstrip.(read(io, String))
#a = map(x -> parse(Int,x), stringvec)
show(stringvec)
