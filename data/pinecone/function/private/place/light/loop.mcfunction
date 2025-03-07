#get offset
data modify storage pinecone:tmp place_info.light_offsetX set from storage pinecone:tmp place_fur_data.placement.light[0].pos[0]
data modify storage pinecone:tmp place_info.light_offsetY set from storage pinecone:tmp place_fur_data.placement.light[0].pos[1]
data modify storage pinecone:tmp place_info.light_offsetZ set from storage pinecone:tmp place_fur_data.placement.light[0].pos[2]
data modify storage pinecone:tmp place_info.light_level set from storage pinecone:tmp place_fur_data.placement.light[0].level

#move to offset and place
function pinecone:private/place/light/move with storage pinecone:tmp place_info

#remove data
data remove storage pinecone:tmp place_fur_data.placement.light[0]
execute if data storage pinecone:tmp place_fur_data.placement.light[0] run function pinecone:private/place/light/loop