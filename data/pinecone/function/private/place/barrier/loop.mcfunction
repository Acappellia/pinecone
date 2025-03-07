#get offset
data modify storage pinecone:tmp place_info.barrier_offsetX set from storage pinecone:tmp place_fur_data.placement.barrier[0][0]
data modify storage pinecone:tmp place_info.barrier_offsetY set from storage pinecone:tmp place_fur_data.placement.barrier[0][1]
data modify storage pinecone:tmp place_info.barrier_offsetZ set from storage pinecone:tmp place_fur_data.placement.barrier[0][2]

#move to offset and place
function pinecone:private/place/barrier/move with storage pinecone:tmp place_info

#remove data
data remove storage pinecone:tmp place_fur_data.placement.barrier[0]
execute if data storage pinecone:tmp place_fur_data.placement.barrier[0] run function pinecone:private/place/barrier/loop