import csv, sys, getopt, json, os

def hex_to_rgb(hex_color):
    hex_color = hex_color.lstrip('#')
    
    if len(hex_color) == 3:
        hex_color = ''.join([c * 2 for c in hex_color])
    
    r = int(hex_color[0:2], 16)
    g = int(hex_color[2:4], 16)
    b = int(hex_color[4:6], 16)
    
    return r, g, b

def rgb_to_hex(r, g, b):
    return '#{:02x}{:02x}{:02x}'.format(int(r), int(g), int(b))

def rgb_to_int(r, g, b):
    return (int(r) << 16) | (int(g) << 8) | int(b)

abs_path = os.path.abspath('.')
out_path = abs_path + '/data/pinecone/function/private/brush/set_color/'

#read csv file
rows = []
with open(abs_path + '/colors.hex', 'r') as color_file:
    rows = color_file.readlines

#calc rgb value
colorhex = []
colorint = []
for row in rows:
    colorhex.append('#' + row)
    colorint.append(rgb_to_int(hex_to_rgb(row)))

for i in range(32):
    commands = 'title @s actionbar [{"text":"选色: ","color":"gray"},{"text":"[ ","color":"white"},'
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
    with open(out_path + str(i) + '.mcfunction','w') as function_file:
        function_file.writelines(commands)
        function_file.close()