import json
import os

# cd ares-1

FOLDER = "gentx"
if not os.path.exists(FOLDER):
    print("gentx folder not found")
    exit(1)

# get all files within the gentx folder
gentx_files = os.listdir(FOLDER)

invalids = ""
output = ""

for file in gentx_files:
    if not file.endswith(".json"):
        continue

    f = open("gentx/" + file, "r")
    data = json.load(f)

    validatorData = data["body"]["messages"][0]
    moniker = validatorData["description"]["moniker"]
    rate = float(validatorData["commission"]["rate"]) * 100
    valop = validatorData["validator_address"]
    denom = validatorData["value"]["denom"]
    amt = int(validatorData["value"]["amount"]) / 1_000_000  # human readable

    if denom != "ujunox":
        invalids += f"[!] Invalid denomination for validator: {moniker} {denom} \n"
    elif amt != 9000:  # human readable
        invalids += f"[!] Invalid amount for validator: {moniker} {amt}\n"
    else:
        output += f"{valop} {rate}%\t{denom}: {amt}, {moniker.strip()}\n"

print(output)
print(f"{invalids}")
