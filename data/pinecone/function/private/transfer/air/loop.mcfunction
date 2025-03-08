#get offset
data modify storage pinecone:tmp transfer_info.air_offsetX set from storage pinecone:tmp transfer_target_fur_data.placement.air[0][0]
data modify storage pinecone:tmp transfer_info.air_offsetY set from storage pinecone:tmp transfer_target_fur_data.placement.air[0][1]
data modify storage pinecone:tmp transfer_info.air_offsetZ set from storage pinecone:tmp transfer_target_fur_data.placement.air[0][2]

#move to offset and place
function pinecone:private/transfer/air/move with storage pinecone:tmp transfer_info

#remove data
data remove storage pinecone:tmp transfer_fur_data.placement.air[0]
execute if data storage pinecone:tmp transfer_fur_data.placement.air[0] run function pinecone:private/transfer/air/loop