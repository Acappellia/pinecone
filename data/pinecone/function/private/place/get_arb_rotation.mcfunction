execute store result score #player_rotation pinecone run data get entity @s Rotation[0]

data modify storage pinecone:tmp place_info.rotation set from entity @s Rotation[0]

execute if score #player_rotation pinecone matches -4..4 run data modify storage pinecone:tmp place_info.rotation set value 0
execute if score #player_rotation pinecone matches 86..94 run data modify storage pinecone:tmp place_info.rotation set value 90
execute if score #player_rotation pinecone matches 176.. run data modify storage pinecone:tmp place_info.rotation set value 180
execute if score #player_rotation pinecone matches ..-176 run data modify storage pinecone:tmp place_info.rotation set value -180
execute if score #player_rotation pinecone matches -94..-86 run data modify storage pinecone:tmp place_info.rotation set value -90