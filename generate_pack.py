# All files should be put in the /models_to_add/ directory
# Run this script with -i <new_pack_name>

import csv, json, os, shutil, re, zipfile

#read args
abs_path = os.path.abspath('.')
print('Please enter the new pack name. Can only be named using \'a-z\', \'0-9\', \'_\', \'-\'')
raw_input = input()
pack_name = re.sub(r'[^a-z0-9-_]', '', raw_input)
if pack_name == '':
    pack_name = 'unnamed_pack'
print('New furniture pack is named: ' + pack_name)

#init dirs
import_dir = abs_path + '/models_to_add'

model_file_loc = abs_path + '/assets/' + pack_name + '/items/'
json_file_loc = abs_path + '/assets/' + pack_name + '/models/pinecone/'
png_file_loc = abs_path + '/assets/' + pack_name + '/textures/item/'
atlases_file_loc = abs_path + '/assets/' + pack_name + '/atlases/'

dp_private_loc = abs_path + '/data/' + pack_name + '/function/private/'
dp_loc = abs_path + '/data/' + pack_name + '/function/'
dp_adv_loc = abs_path + '/data/' + pack_name + '/advancement/'
dp_recipe_loc = abs_path + '/data/' + pack_name + '/recipe/'

function_init_file = abs_path + '/data/minecraft/tags/function/load.json'
csv_file = abs_path + '/furniture_import_sheet.csv'

os.makedirs(model_file_loc,exist_ok=True)
os.makedirs(json_file_loc,exist_ok=True)
os.makedirs(png_file_loc,exist_ok=True)
#os.makedirs(atlases_file_loc,exist_ok=True)
os.makedirs(dp_private_loc,exist_ok=True)
os.makedirs(dp_adv_loc,exist_ok=True)
os.makedirs(dp_recipe_loc,exist_ok=True)

#read csv
csv_rows = []
with open(csv_file) as file:
    csvreader = csv.reader(file)
    header = next(csvreader)
    for row in csvreader:
        csv_rows.append(row)

#find all files
json_file_list = []
png_file_list = []

for root, _, files in os.walk(import_dir):
    for file in files:
        file_path = os.path.join(root, file)
        if file_path.endswith('.json'):
            json_file_list.append(file_path)
        elif file_path.endswith('.png'):
            png_file_list.append(file_path)

json_file_count = len(json_file_list)
png_file_count = len(png_file_list)

print('Found', json_file_count, 'JSON files and', png_file_count, 'PNG files')

#copy & modify json files
for file_name in json_file_list:
    shutil.copy2(file_name, json_file_loc)
    with open(json_file_loc + os.path.split(file_name)[1], 'r+') as file:
        jsondata = json.load(file)
        for key in jsondata['textures']:
            png_dir = jsondata['textures'][key]
            new_png_dir = pack_name + ':item/' + str.split(png_dir,'/')[-1]
            jsondata['textures'][key] = new_png_dir
        file.seek(0)
        file.write(json.dumps(jsondata,indent=2))
        file.truncate()

#copy png files
for file_name in png_file_list:
    shutil.copy2(file_name, png_file_loc)

#add atlases file
#with open(atlases_file_loc + 'blocks.json', 'w') as file:
#    jsondata = {'sources':[{'type':'directory','source': pack_name + ':pinecone','prefix': pack_name + ':pinecone/'}]}
#    file.write(json.dumps(jsondata,indent=2))

#default recipe
recipe_cut = {
    "type": "minecraft:stonecutting",
    "category": "building",
    "ingredient": "minecraft:apple",
    "result": {
        "count": 1, 
        "id": "minecraft:leather_horse_armor", 
        "components": {
            "minecraft:item_name": "Template", 
            "minecraft:item_model": "minecraft:apple", 
            "minecraft:custom_data": {
                "pinecone_fur": 1
            },
            "consumable": {
                "animation": "none",
                "consume_seconds": 1000000,
                "has_consume_particles": False
            },
            "attribute_modifiers": {
                "modifiers": [],
                "show_in_tooltip": False
            },
            "max_stack_size":64
        }
    }
}

#default item model
item_model = {
    "model": {
        "type": "model",
        "model": "pinecone:pinecone/brush",
        "tints": [
            {
                "type": "dye",
                "default": -1
            }
        ]
    }
}

#init mcfunction and advancement
with open(dp_private_loc + 'init.mcfunction', 'w') as file:
    file.write('#init ' + pack_name + ' furniture data')

with open(dp_loc + 'give_all.mcfunction', 'w') as file:
    give_brush_cmd = 'give @s leather_horse_armor[item_model="pinecone:brush",custom_data={pinecone_brush:1b},consumable={animation:"none",consume_seconds:1000000,has_consume_particles:false},attribute_modifiers={modifiers:[],show_in_tooltip:false},item_name=\'"颜料刷"\',lore=[\'[{"text":"手持时：","color":"gray","italic":false}]\',\'[{"text":"[","color":"gray","italic":false},{"keybind": "key.sneak","color":"white","italic":false},{"text":"+","color":"gray","italic":false},{"keybind": "key.use","color":"white","italic":false},{"text":"] ","color":"gray","italic":false},{"text":"循环切换刷子颜色","color":"white","italic":false}]\',\'[{"text":"[","color":"gray","italic":false},{"keybind": "key.use","color":"white","italic":false},{"text":"] ","color":"gray","italic":false},{"text":"对准家具并涂色","color":"white","italic":false}]\']]'
    file.write('#give all furnitures in ' + pack_name + '\n' + give_brush_cmd)

advancement_json = {
    "criteria": {
        "auto": {
            "trigger": "location"
        }
    },
    "rewards": {
        "recipes": [
        ]
    }
}

print('Found', len(csv_rows), 'defined furnitures')

#add furnitures
for row in csv_rows:
    if row[0] == '':
        continue
    furniture_id = row[0]
    furniture_full_id = pack_name + ':' + furniture_id
    
    #create item model
    model_json = item_model
    model_json['model']['model'] = pack_name +':pinecone/' + furniture_id
    with open(model_file_loc + furniture_id +'.json','w') as file:
        file.write(json.dumps(model_json,indent=2))
    
    #create recipe
    if row[2] != '':
        recipe_json = recipe_cut
        recipe_json['ingredient'] = row[2]
        recipe_json['result']['components']['minecraft:item_name'] = row[1]
        recipe_json['result']['components']['minecraft:item_model'] = furniture_full_id
        with open(dp_recipe_loc + furniture_id +'.json','w') as file:
            file.write(json.dumps(recipe_json,indent=2,ensure_ascii=False))
        
        #add recipe to advancement
        advancement_json['rewards']['recipes'].append(furniture_full_id)

    #add furniture init data
    init_command = 'data modify storage pinecone:fur_data "' + furniture_full_id + '" set value {\\\n'

    init_command += 'transfer:{'
    if row[15] != '':
        init_command += 'target:"' + pack_name + ':' + row[15] + '"'
        if row[16] == '1':
            init_command += ',require_tool:1b'
    init_command += '},\\\n'

    init_command += 'placement:{'
    if row[8] == '1':
        init_command += 'align_block:1b,'
    if row[9] == '1':
        init_command += 'arb_rotation:1b,'
    if row[7] != '':
        init_command += 'offset:' + row[7] + ','
    if row[4] != '':
        init_command += 'barrier:[' + row[4] + '],'
    if row[5] != '':
        init_command += 'light:[' + row[5] + '],'
    if row[6] != '':
        init_command += 'air:[' + row[6] + '],'
    if row[3] != '':
        init_command += 'bounding_box:' + row[3]
    else:
        init_command += 'bounding_box:[1.0,1.0]'
    init_command += '},\\\n'

    init_command += 'item_data:{'
    init_command += 'id:"minecraft:leather_horse_armor",count:1,components:{item_model:"' + furniture_full_id + '",item_name:\'"' + row[1] + '"\'}'
    init_command += '},\\\n'

    init_command += 'interaction:{'
    if row[10] == '1':
        init_command += 'is_seat:1b'
        if row[11] != '':
            init_command += ',seat_height:' + row[11]
        if row[12] == '1':
            init_command += ',is_shake:1b'
    elif row[12] == '1':
        init_command += 'is_shake:1b'
    init_command += '},\\\n'

    init_command += 'auto:{'
    if row[13] == '1':
        init_command += 'rotate_left:1b'
    elif row[14] == '1':
        init_command += 'rotate_right:1b'
    init_command += '}}\n'

    with open(dp_private_loc + 'init.mcfunction', 'a') as file:
        file.write('\n' + init_command)
    
    #add furniture give_all
    give_command = 'give @s leather_horse_armor[item_model="' + furniture_full_id + '",custom_data={pinecone_fur:1b},consumable={animation:"none",consume_seconds:1000000,has_consume_particles:false},max_stack_size=64,attribute_modifiers={modifiers:[],show_in_tooltip:false},item_name=\'"' + row[1] + '"\']'
    with open(dp_loc + 'give_all.mcfunction', 'a') as file:
        file.write('\n' + give_command)

#write advancement
with open(dp_adv_loc + 'give_recipe.json', 'w') as file:
    file.write(json.dumps(advancement_json,indent=2))

#modify datapack init
with open(function_init_file, 'r+') as file:
    jsondata = json.load(file)
    new_function_dic = {'id': pack_name + ':private/init','required':False}
    jsondata['values'].append(new_function_dic)
    file.seek(0)
    file.write(json.dumps(jsondata,indent=2))
    file.truncate()

#modify pack.mcmeta
with open (abs_path + '/pack.mcmeta', 'r+') as file:
    jsondata = json.load(file)
    jsondata['pack']['description'][1]['text'] = pack_name
    file.seek(0)
    file.write(json.dumps(jsondata,indent=2,ensure_ascii=False))
    file.truncate() 

#pack to zip
print('Packing to zip..')
TARGET_DIRS = [abs_path + "/data", abs_path + "/assets"]

def add_directory_to_zip(zipf, directory):
    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            arcname = os.path.relpath(file_path, start=os.path.dirname(directory))
            zipf.write(file_path, arcname=arcname)

with zipfile.ZipFile(abs_path + '/generated_pack.zip', "w", zipfile.ZIP_DEFLATED) as zipf:
    for directory in TARGET_DIRS:
        add_directory_to_zip(zipf, directory)
    zipf.write(abs_path + '/pack.mcmeta', 'pack.mcmeta')
    zipf.write(abs_path + '/pack.png', 'pack.png')

#complete
print('Complete!')