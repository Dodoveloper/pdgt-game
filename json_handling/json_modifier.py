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
    return sum

# start modifying the json
with open(input_json, 'r') as f:
    data = json.load(f)
    print("Loaded json file.")

# iterate through each element of the array
for i, val in enumerate(data):
    print(pit_sum(data[i]), data[i]["cnumero_pozzi_allacciati__"])
    # iterate through the elements of each dict
    for k, v in list(data[i].items()):
        if k == "ctitolo_minerario" or k == "cfoglio":
            del data[i][k]
    # delete platforms with few pits
    if int(data[i]["cnumero_pozzi_allacciati__"]) < 4:
        print("Deleting %s with %s total pits" % (data[i]["cdenominazione__"], data[i]["cnumero_pozzi_allacciati__"]))
        del data[i]

print(len(data))

with open(input_json, 'w') as f:
    json.dump(data, f)
    print("Dumped changes to json.")
