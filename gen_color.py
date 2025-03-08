import csv, sys, getopt, json, os

def rgb_to_hex(r, g, b):
    return '#{:02x}{:02x}{:02x}'.format(int(r), int(g), int(b))

def rgb_to_int(r, g, b):
    return (int(r) << 16) | (int(g) << 8) | int(b)

abs_path = os.path.abspath('.')

try:
    os.mkdir(abs_path + '/color_output/')
except FileExistsError: 
    pass

#read csv file
rows = []
with open(abs_path + '/colors.csv', 'r') as color_file:
    csvreader = csv.reader(color_file)
    header = next(csvreader)
    for row in csvreader:
        rows.append(row)

#calc rgb value
colorhex = []
colorint = []
for row in rows:
    colorhex.append(rgb_to_hex(*row))
    colorint.append(rgb_to_int(*row))

for i in range(32):
    commands = 'title @s actionbar [{"text":"[ ","color":"white"},'
    text_block = []
    for j in range (i-8,i+9):
        if j >= 32:
            j -= 32
        if j == i:
            text_block.append('{"text": "■","color": "' + colorhex[j] + '","bold":true,"underlined":true}')
        else:
            text_block.append('{"text": "■","color": "' + colorhex[j] + '"}')
    commands += ','.join(text_block)
    commands += ',{"text":" ]","color":"white"}]\nitem modify entity @s weapon.mainhand {function:"set_components",components:{dyed_color:{rgb:' + str(colorint[i]) + '},custom_data:{pinecone_brush:1b,pinecone_brush_color:' + str(i) + '}}}'
    with open(abs_path + '/color_output/' + str(i) + '.mcfunction','w') as function_file:
        function_file.writelines(commands)
        function_file.close()