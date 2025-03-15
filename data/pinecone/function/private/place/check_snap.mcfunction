#get bounding box
execute store result storage pinecone:tmp normal_info.half_width float 0.5 run data get storage pinecone:tmp place_fur_data.placement.bounding_box[0]
data modify storage pinecone:tmp normal_info.height set from storage pinecone:tmp place_fur_data.placement.bounding_box[1]

#check if snap
execute align xz positioned ~0.5 ~ ~0.5 if predicate pinecone:near_center as @p[tag=pinecone_placer,distance=..7] run return run function pinecone:private/place/check_normal with storage pinecone:tmp normal_info
execute as @p[tag=pinecone_placer,distance=..7] run function pinecone:private/place/check_normal with storage pinecone:tmp normal_info