execute store result score #ray_hit_normal_x pinecone run data get storage bs:out raycast.hit_normal[0]
execute store result score #ray_hit_normal_y pinecone run data get storage bs:out raycast.hit_normal[1]
execute store result score #ray_hit_normal_z pinecone run data get storage bs:out raycast.hit_normal[2]

execute if score #ray_hit_normal_y pinecone matches 1 run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_y pinecone matches -1 positioned ~ ~-$(height) ~ run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_x pinecone matches -1 positioned ~-$(half_width) ~ ~ run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_x pinecone matches 1 positioned ~$(half_width) ~ ~ run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_z pinecone matches -1 positioned ~ ~ ~-$(half_width) run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_z pinecone matches 1 positioned ~ ~ ~$(half_width) run return run function pinecone:private/place/summon_fur