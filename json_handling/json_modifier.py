import json

input_json = "Elenco-piattaforme-marine - Copia.json"
data = None

# sum of available pits
def pit_sum(platform):
    sum = 0
    if platform["cpozzi_produttivi_non_eroganti"] != "":
        sum += int(platform["cpozzi_produttivi_non_eroganti"])
    if platform["cpozzi_in_produzione"] != "":
        sum += int(platform["cpozzi_in_produzione"])
        if platform["cpozzi_in_monitoraggio"] != "":
            sum += int(platform["cpozzi_in_monitoraggio"])
    return sum

# start modifying the json
with open(input_json, 'r') as f:
    data = json.load(f)
    print("Loaded json file.")

# iterate through each element of the array
for i, val in enumerate(data):
    # iterate through the elements of each dict
    for k, v in list(data[i].items()):
        if k == "ctitolo_minerario" or k == "cfoglio":
            del data[i][k]
    print(pit_sum(data[i]))

with open(input_json, 'w') as f:
    json.dump(data, f)
    print("Dumped changes to json.")
