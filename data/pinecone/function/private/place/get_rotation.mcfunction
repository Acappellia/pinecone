#if arb_rotation store rotation
execute if data storage pinecone:tmp place_fur_data.placement{arb_rotation:1b} run return run function pinecone:private/place/get_arb_rotation

#if not arb_rotation align to axis
function pinecone:private/place/get_rotation_4