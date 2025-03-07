#place barrier
execute if block ~ ~ ~ #pinecone:air_blocks_replace run setblock ~ ~ ~ barrier[waterlogged=false]
execute if block ~ ~ ~ #pinecone:water_blocks_replace run setblock ~ ~ ~ barrier[waterlogged=true]
execute if block ~ ~ ~ #pinecone:waterloggable_blocks_replace[waterlogged=true] run setblock ~ ~ ~ barrier[waterlogged=true]
execute if block ~ ~ ~ #pinecone:waterloggable_blocks_replace[waterlogged=false] run setblock ~ ~ ~ barrier[waterlogged=false]