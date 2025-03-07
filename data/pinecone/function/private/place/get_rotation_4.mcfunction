execute store result score #player_rotation pinecone run data get entity @s Rotation[0]
execute if score #player_rotation pinecone matches -44..45 run data modify storage pinecone:tmp place_info.rotation set value 0
execute if score #player_rotation pinecone matches 46..135 run data modify storage pinecone:tmp place_info.rotation set value 90
execute if score #player_rotation pinecone matches 136.. run data modify storage pinecone:tmp place_info.rotation set value 180
execute if score #player_rotation pinecone matches ..-135 run data modify storage pinecone:tmp place_info.rotation set value -180
execute if score #player_rotation pinecone matches -134..-45 run data modify storage pinecone:tmp place_info.rotation set value -90