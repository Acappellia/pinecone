#get offset
data modify storage pinecone:tmp transfer_info.barrier_offsetX set from storage pinecone:tmp transfer_target_fur_data.placement.barrier[0][0]
data modify storage pinecone:tmp transfer_info.barrier_offsetY set from storage pinecone:tmp transfer_target_fur_data.placement.barrier[0][1]
data modify storage pinecone:tmp transfer_info.barrier_offsetZ set from storage pinecone:tmp transfer_target_fur_data.placement.barrier[0][2]

#move to offset and place
function pinecone:private/transfer/barrier/move with storage pinecone:tmp transfer_info

#remove data
data remove storage pinecone:tmp transfer_target_fur_data.placement.barrier[0]
execute if data storage pinecone:tmp transfer_target_fur_data.placement.barrier[0] run function pinecone:private/transfer/barrier/loop