#place light
$execute if block ~ ~ ~ #pinecone:air_blocks_replace run setblock ~ ~ ~ light[waterlogged=false,level=$(light_level)]
$execute if block ~ ~ ~ #pinecone:water_blocks_replace run setblock ~ ~ ~ light[waterlogged=true,level=$(light_level)]
$execute if block ~ ~ ~ #pinecone:waterloggable_blocks_replace[waterlogged=true] run setblock ~ ~ ~ light[waterlogged=true,level=$(light_level)]
$execute if block ~ ~ ~ #pinecone:waterloggable_blocks_replace[waterlogged=false] run setblock ~ ~ ~ light[waterlogged=false,level=$(light_level)]