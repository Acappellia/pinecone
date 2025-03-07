#get offset
data modify storage pinecone:tmp remove_info.light_offsetX set from storage pinecone:tmp remove_fur_data.placement.light[0].pos[0]
data modify storage pinecone:tmp remove_info.light_offsetY set from storage pinecone:tmp remove_fur_data.placement.light[0].pos[1]
data modify storage pinecone:tmp remove_info.light_offsetZ set from storage pinecone:tmp remove_fur_data.placement.light[0].pos[2]

#move to offset and place
function pinecone:private/break/light/move with storage pinecone:tmp remove_info

#remove data
data remove storage pinecone:tmp remove_fur_data.placement.light[0]
execute if data storage pinecone:tmp remove_fur_data.placement.light[0] run function pinecone:private/break/light/loop