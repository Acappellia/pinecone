execute if score #ray_hit_normal_y pinecone matches 1 run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_y pinecone matches -1 positioned ~ ~-$(height) ~ run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_x pinecone matches -1 positioned ~-$(half_width) ~ ~ run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_x pinecone matches 1 positioned ~$(half_width) ~ ~ run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_z pinecone matches -1 positioned ~ ~ ~-$(half_width) run return run function pinecone:private/place/summon_fur
$execute if score #ray_hit_normal_z pinecone matches 1 positioned ~ ~ ~$(half_width) run return run function pinecone:private/place/summon_fur