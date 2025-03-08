#get offset
data modify storage pinecone:tmp transfer_info.light_offsetX set from storage pinecone:tmp transfer_target_fur_data.placement.light[0].pos[0]
data modify storage pinecone:tmp transfer_info.light_offsetY set from storage pinecone:tmp transfer_target_fur_data.placement.light[0].pos[1]
data modify storage pinecone:tmp transfer_info.light_offsetZ set from storage pinecone:tmp transfer_target_fur_data.placement.light[0].pos[2]
data modify storage pinecone:tmp transfer_info.light_level set from storage pinecone:tmp transfer_target_fur_data.placement.light[0].level

#move to offset and place
function pinecone:private/transfer/light/move with storage pinecone:tmp transfer_info

#remove data
data remove storage pinecone:tmp transfer_target_fur_data.placement.light[0]
execute if data storage pinecone:tmp transfer_target_fur_data.placement.light[0] run function pinecone:private/transfer/light/loop