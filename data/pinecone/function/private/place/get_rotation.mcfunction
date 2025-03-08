#if arb_rotation store rotation
execute if data storage pinecone:tmp place_fur_data.placement{arb_rotation:1b} run return run data modify storage pinecone:tmp place_info.rotation set from entity @s Rotation[0]

#if not arb_rotation align to axis
function pinecone:private/place/get_rotation_4