#remove barrier
execute if block ~ ~ ~ barrier[waterlogged=true] run setblock ~ ~ ~ water
execute if block ~ ~ ~ barrier[waterlogged=false] run setblock ~ ~ ~ air