# All files should be put in the /models_to_add/ directory
# Run this script with -i <new_pack_name>

import csv, json, os, shutil, re, zipfile

#read args
ABS_PATH = os.path.abspath('.')
print('Please enter the new pack name. Can only be named using \'a-z\', \'0-9\', \'_\', \'-\'')
raw_input = input()
pack_name = re.sub(r'[^a-z0-9-_]', '', raw_input)
if pack_name == '':
    pack_name = 'unnamed_pack'
print('New furniture pack is named: ' + pack_name)

#init dirs
IMPORT_DIR = ABS_PATH + '/models_to_add'

MODEL_FILE_LOC = ABS_PATH + '/assets/' + pack_name + '/items/'
JSON_FILE_LOC = ABS_PATH + '/assets/' + pack_name + '/models/pinecone/'
PNG_FILE_LOC = ABS_PATH + '/assets/' + pack_name + '/textures/item/'
ATLASES_FILE_LOC = ABS_PATH + '/assets/' + pack_name + '/atlases/'

DP_PRIVATE_LOC = ABS_PATH + '/data/' + pack_name + '/function/private/'
DP_LOC = ABS_PATH + '/data/' + pack_name + '/function/'
DP_ADV_LOC = ABS_PATH + '/data/' + pack_name + '/advancement/'
DP_RECIPE_LOC = ABS_PATH + '/data/' + pack_name + '/recipe/'

FUNC_INIT_FILE = ABS_PATH + '/data/minecraft/tags/function/load.json'
CSV_FILE = ABS_PATH + '/furniture_import_sheet.csv'

os.makedirs(MODEL_FILE_LOC,exist_ok=True)
os.makedirs(JSON_FILE_LOC,exist_ok=True)
os.makedirs(PNG_FILE_LOC,exist_ok=True)
#os.makedirs(ATLASES_FILE_LOC,exist_ok=True)
os.makedirs(DP_PRIVATE_LOC,exist_ok=True)
os.makedirs(DP_ADV_LOC,exist_ok=True)
os.makedirs(DP_RECIPE_LOC,exist_ok=True)

#read csv
csv_rows = []
with open(CSV_FILE, encoding='utf-8') as file:
    csvreader = csv.reader(file)
    header = next(csvreader)
    for row in csvreader:
        csv_rows.append(row)

#find all files
json_file_list = []
png_file_list = []

for root, _, files in os.walk(IMPORT_DIR):
    for file in files:
        file_path = os.path.join(root, file)
        if file_path.endswith('.json'):
            json_file_list.append(file_path)
        elif file_path.endswith('.png'):
            png_file_list.append(file_path)
        elif file_path.endswith('.png.mcmeta'):
            png_file_list.append(file_path)

json_file_count = len(json_file_list)
png_file_count = len(png_file_list)

print('Found', json_file_count, 'JSON files and', png_file_count, 'PNG files')

#copy & modify json files

MC_PARENT = ['minecraft:block/cube_all','minecraft:item/generated']

for file_name in json_file_list:
    shutil.copy2(file_name, JSON_FILE_LOC)
    with open(JSON_FILE_LOC + os.path.split(file_name)[1], 'r+', encoding='utf-8') as file:
        jsondata = json.load(file)
        if 'textures' in jsondata:
            for key in jsondata['textures']:
                png_dir = jsondata['textures'][key]
                new_png_dir = pack_name + ':item/' + (png_dir.split(':')[-1]).split('/')[-1]
                jsondata['textures'][key] = new_png_dir
        if 'parent' in jsondata:
            if jsondata['parent'] not in MC_PARENT:
                jsondata['parent'] = pack_name + ':pinecone/' + (jsondata['parent'].split(':')[-1]).split('/')[-1]
        file.seek(0)
        file.write(json.dumps(jsondata,indent=2))
        file.truncate()

#copy png files
for file_name in png_file_list:
    shutil.copy2(file_name, PNG_FILE_LOC)

#add atlases file
#with open(ATLASES_FILE_LOC + 'blocks.json', 'w', encoding='utf-8') as file:
#    jsondata = {'sources':[{'type':'directory','source': pack_name + ':pinecone','prefix': pack_name + ':pinecone/'}]}
#    file.write(json.dumps(jsondata,indent=2))

#default recipe
RECIPE_CUT = {
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
            "tooltip_display":{
                "hidden_components":[
                    "attribute_modifiers"
                ]
            },
            "max_stack_size":64
        }
    }
}

#default item model
ITEM_MODEL = {
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
with open(DP_PRIVATE_LOC + 'init.mcfunction', 'w', encoding='utf-8') as file:
    file.write('#init ' + pack_name + ' furniture data')

with open(DP_LOC + 'give_all.mcfunction', 'w', encoding='utf-8') as file:
    give_brush_cmd = 'give @s leather_horse_armor[item_model="pinecone:brush",custom_data={pinecone_brush:1b},consumable={animation:"none",consume_seconds:1000000,has_consume_particles:false},tooltip_display={hidden_components:["attribute_modifiers"]},item_name="颜料刷",lore=[\'[{"text":"手持时：","color":"gray","italic":false}]\',\'[{"text":"[","color":"gray","italic":false},{"keybind": "key.sneak","color":"white","italic":false},{"text":"+","color":"gray","italic":false},{"keybind": "key.use","color":"white","italic":false},{"text":"] ","color":"gray","italic":false},{"text":"循环切换刷子颜色","color":"white","italic":false}]\',\'[{"text":"[","color":"gray","italic":false},{"keybind": "key.use","color":"white","italic":false},{"text":"] ","color":"gray","italic":false},{"text":"对准家具并涂色","color":"white","italic":false}]\']]'
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
    model_json = ITEM_MODEL
    model_json['model']['model'] = pack_name +':pinecone/' + furniture_id
    with open(MODEL_FILE_LOC + furniture_id +'.json','w', encoding='utf-8') as file:
        file.write(json.dumps(model_json,indent=2))
    
    #create recipe
    if row[2] != '':
        recipe_json = RECIPE_CUT
        recipe_json['ingredient'] = row[2]
        if row[19] != '':
            recipe_json['result']['id'] = row[19]
        recipe_json['result']['components']['minecraft:item_name'] = row[1]
        recipe_json['result']['components']['minecraft:item_model'] = furniture_full_id
        if row[17] == '1':
            recipe_json['result']['components']['consumable'] = {}
            recipe_json['result']['components']['food'] = {'can_always_eat': True, 'nutrition': round(float(row[18])), 'saturation': float(row[18])}
        with open(DP_RECIPE_LOC + furniture_id +'.json','w', encoding='utf-8') as file:
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
        init_command += 'bounding_box:[1.01,1.01]'
    init_command += '},\\\n'

    init_command += 'item_data:{'
    if row[19] == '':
        init_command += 'id:"minecraft:leather_horse_armor",count:1,components:{item_model:"' + furniture_full_id + '",item_name:"' + row[1] + '"'
    else:
        init_command += 'id:"' + row[19] + '",count:1,components:{item_model:"' + furniture_full_id + '",item_name:"' + row[1] + '"'
    if row[17] == '1':
        init_command += ',food:{can_always_eat:1b,nutrition:' + str(round(float(row[18]))) + ',saturation:' + row[18] + '}'
        init_command += ',consumable:{}'
    else:
        init_command += ',consumable:{animation:"none",consume_seconds:1000000,has_consume_particles:0b}'
    init_command += '}},\\\n'

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
    elif row[20] == '1':
        init_command += 'rotate_vleft:1b'
    elif row[21] == '1':
        init_command += 'rotate_vright:1b'
    init_command += '}}\n'

    with open(DP_PRIVATE_LOC + 'init.mcfunction', 'a', encoding='utf-8') as file:
        file.write('\n' + init_command)
    
    #add furniture give_all
    give_command = ''
    if row[19] != '':
        give_command += 'give @s ' + row[19] + '[item_model="' + furniture_full_id + '",custom_data={pinecone_fur:1b},'
    else:
        give_command += 'give @s leather_horse_armor[item_model="' + furniture_full_id + '",custom_data={pinecone_fur:1b},'
    if row[17] == '1':
        give_command += 'consumable={},food={can_always_eat:1b,nutrition:' + str(round(float(row[18]))) + ',saturation:' + row[18] + '},max_stack_size=64,tooltip_display={hidden_components:["attribute_modifiers"]},item_name="' + row[1] + '"]'
    else:
        give_command += 'consumable={animation:"none",consume_seconds:1000000,has_consume_particles:false},max_stack_size=64,tooltip_display={hidden_components:["attribute_modifiers"]},item_name="' + row[1] + '"]'
    with open(DP_LOC + 'give_all.mcfunction', 'a', encoding='utf-8') as file:
        file.write('\n' + give_command)

#write advancement
with open(DP_ADV_LOC + 'give_recipe.json', 'w', encoding='utf-8') as file:
    file.write(json.dumps(advancement_json,indent=2))

#modify datapack init
with open(FUNC_INIT_FILE, 'r+', encoding='utf-8') as file:
    jsondata = json.load(file)
    function_id = pack_name + ':private/init'
    if jsondata['values'][-1]['id'] != function_id:
        new_function_dic = {'id': function_id,'required':False}
        jsondata['values'].append(new_function_dic)
        file.seek(0)
        file.write(json.dumps(jsondata,indent=2))
        file.truncate()

#modify pack.mcmeta
with open (ABS_PATH + '/pack.mcmeta', 'r+', encoding='utf-8') as file:
    jsondata = json.load(file)
    if jsondata['pack']['description'][1]['text'] == 'unnamed_pack':
        jsondata['pack']['description'][1]['text'] = pack_name
        file.seek(0)
        file.write(json.dumps(jsondata,indent=2,ensure_ascii=False))
        file.truncate()

#pack to zip
print('Packing to zip..')
TARGET_DIRS = [ABS_PATH + "/data", ABS_PATH + "/assets"]

def add_directory_to_zip(zipf, directory):
    for root, _, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            arcname = os.path.relpath(file_path, start=os.path.dirname(directory))
            zipf.write(file_path, arcname=arcname)

with zipfile.ZipFile(ABS_PATH + '/pinecone-' + pack_name + '-1.21.4.zip', "w", zipfile.ZIP_DEFLATED) as zipf:
    for directory in TARGET_DIRS:
        add_directory_to_zip(zipf, directory)
    zipf.write(ABS_PATH + '/pack.mcmeta', 'pack.mcmeta')
    zipf.write(ABS_PATH + '/pack.png', 'pack.png')
    zipf.write(ABS_PATH + '/LICENSE', 'LICENSE')

#complete
print('Complete!')
os.system('PAUSE')