#if place with offset is a solid block, return
execute if block ~ ~ ~ #pinecone:all_blocks_replace run return run function pinecone:private/place/summon_fur_grid

execute if score #ray_hit_normal_y pinecone matches 1 positioned ~ ~1 ~ run return run execute if block ~ ~ ~ #pinecone:all_blocks_replace run function pinecone:private/place/summon_fur_grid
execute if score #ray_hit_normal_x pinecone matches 1 positioned ~1 ~ ~ run return run execute if block ~ ~ ~ #pinecone:all_blocks_replace run function pinecone:private/place/summon_fur_grid
execute if score #ray_hit_normal_x pinecone matches -1 positioned ~-1 ~ ~ run return run execute if block ~ ~ ~ #pinecone:all_blocks_replace run function pinecone:private/place/summon_fur_grid
execute if score #ray_hit_normal_z pinecone matches 1 positioned ~ ~ ~1 run return run execute if block ~ ~ ~ #pinecone:all_blocks_replace run function pinecone:private/place/summon_fur_grid
execute if score #ray_hit_normal_z pinecone matches -1 positioned ~ ~ ~-1 run return run execute if block ~ ~ ~ #pinecone:all_blocks_replace run function pinecone:private/place/summon_fur_grid
execute if score #ray_hit_normal_y pinecone matches -1 positioned ~ ~-1 ~ run return run execute if block ~ ~ ~ #pinecone:all_blocks_replace run function pinecone:private/place/summon_fur_grid