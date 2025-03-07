advancement revoke @s only pinecone:use_fur

#check cd
execute unless score @s pinecone_place_cd matches 0.. run return -1

#ray
tag @s add pinecone_placer
execute anchored eyes positioned ^ ^ ^ run function #bs.raycast:run {with:{entities:"pinecone_fur",max_distance:4.5,on_hit_point:"execute as @p[distance=..10,tag=pinecone_placer] run function pinecone:private/place/ray_hit"}}
tag @s remove pinecone_placer

#add cd
scoreboard players set @s pinecone_place_cd -4