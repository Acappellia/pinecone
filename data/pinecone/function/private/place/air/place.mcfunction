#place air
execute if block ~ ~ ~ #pinecone:air_blocks_replace run setblock ~ ~ ~ air
execute if block ~ ~ ~ #pinecone:water_blocks_replace run setblock ~ ~ ~ water
execute if block ~ ~ ~ #pinecone:waterloggable_blocks_replace[waterlogged=true] run setblock ~ ~ ~ water
execute if block ~ ~ ~ #pinecone:waterloggable_blocks_replace[waterlogged=false] run setblock ~ ~ ~ air