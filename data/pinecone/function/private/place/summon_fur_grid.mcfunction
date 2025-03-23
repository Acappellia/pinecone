#summon furniture
function pinecone:private/place/summon_fur

#place barrier
execute if data storage pinecone:tmp place_fur_data.placement.barrier[0] run function pinecone:private/place/barrier/loop

#place light
execute if data storage pinecone:tmp place_fur_data.placement.light[0] run function pinecone:private/place/light/loop

#place air
execute if data storage pinecone:tmp place_fur_data.placement.air[0] run function pinecone:private/place/air/loop