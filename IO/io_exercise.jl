
# File open

## open a file for reading
io = open("data.txt","r")

## open a file by do block
open("data.txt", "r") do io
    ## Read a file at once 
    @show readline(io) #read the first line
    @show readlines(io, keep=false) # read the all lines stored in each list element. if keep is false, the newline characters is removed, otherwise kept. 
end

## open a file and store the whole file.
open("data.txt", "r") do io
    @show read(io, String)
end

## Reading one-by-one
open("data.txt", "r") do io
    for line in eachline(io)
        @show line
    end
end

## Reading one-by-one line with numeric number
open("data.txt", "r") do io
    for (i,line) in enumerate(eachline(io))
        @show i, line
    end
end

# Write a file 
open("output.txt", "w") do io
    write(io, "foo bar\n")
end

open("output.txt", "a") do io
    write(io, "appended line\n")
end

# Write 1 to 5 with newline characters.
open("output.txt", "a") do io 
    for i in 1:5
        write(io, string(i)*"\n")
        # Note that i must be a string when writing. 
    end
end

#rm("output.txt")