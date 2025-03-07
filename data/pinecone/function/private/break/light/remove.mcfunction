#remove light
execute if block ~ ~ ~ light[waterlogged=true] run setblock ~ ~ ~ water
execute if block ~ ~ ~ light[waterlogged=false] run setblock ~ ~ ~ air