import json
import os
from pathlib import Path

current_dir = os.path.dirname(os.path.realpath(__file__))
config = os.path.join(current_dir, "config")

LAUNCH_TIME = "2023-02-10T17:00:00Z"
CHAIN_ID = "ares-1"
GENESIS_FILE = f"{os.path.join(config, 'genesis.json')}"
FOLDER = "gentx"


# if no GENESIS_FILE, create one
if not os.path.exists(GENESIS_FILE):
    print("Genesis file not found. Using pre genesis template...")
    os.makedirs(config, exist_ok=True)
    os.system(
        f"cp {os.path.join(current_dir, 'pre-genesis.json')} {os.path.join(config, 'genesis.json')}"
    )


CUSTOM_GENESIS_ACCOUNT_VALUES = {
    "juno1ep4unl6pdet64ph43sqhxd9hvftdmealqmzrze": "500000000000ujunox # default",
    "juno10r39fueph9fq7a6lgswu4zdsg8t3gxlq670lt0": "6969696969ujunox # reece",
}


def main():
    outputDetails()
    resetGenesisFile()
    createGenesisAccountsCommands()
    pass


def resetGenesisFile():
    # load genesis.json & remove all values for accounts & supply
    with open(GENESIS_FILE) as f:
        genesis = json.load(f)
        genesis["genesis_time"] = LAUNCH_TIME
        genesis["chain_id"] = str(CHAIN_ID)

        genesis["app_state"]["auth"]["accounts"] = []
        genesis["app_state"]["bank"]["balances"] = []
        genesis["app_state"]["bank"]["supply"] = []
        genesis["app_state"]["genutil"]["gen_txs"] = []

        genesis["app_state"]["gov"]["voting_params"]["voting_period"] = "21600s"

    # save genesis.json
    with open(GENESIS_FILE, "w") as f:
        json.dump(genesis, f, indent=4)
    print(f"# RESET: {GENESIS_FILE}\n")


def outputDetails():
    # get the seconds until LAUNCH_TIME
    launch_time = int(os.popen("date -d '" + LAUNCH_TIME + "' +%s").read())
    now = int(os.popen("date +%s").read())
    seconds_until_launch = launch_time - now

    # convert seconds_until_launch to hours, minutes, and seconds
    hours = seconds_until_launch // 3600
    minutes = (seconds_until_launch % 3600) // 60

    print(
        f"# {LAUNCH_TIME} ({hours}h {minutes}m) from now\n# {CHAIN_ID}\n# GenesisFile: {GENESIS_FILE}"
    )


def createGenesisAccountsCommands():
    gentx_files = os.listdir(FOLDER)
    output = "# AUTO GENERATED FROM add-genesis-accounts.py\n"
    for file in gentx_files:
        if not file.endswith(".json"):
            continue

        f = open(FOLDER + "/" + file, "r")
        data = json.load(f)

        validatorData = data["body"]["messages"][0]
        moniker = validatorData["description"]["moniker"]
        val_addr = validatorData["delegator_address"]
        amt = validatorData["value"]["amount"]

        if val_addr not in CUSTOM_GENESIS_ACCOUNT_VALUES.keys():
            output += f"junod add-genesis-account {val_addr} {amt}ujunox --home {current_dir} #{moniker}\n"
            continue  #

    for account in CUSTOM_GENESIS_ACCOUNT_VALUES:
        output += f"junod add-genesis-account --home {current_dir} {account} {CUSTOM_GENESIS_ACCOUNT_VALUES[account]}\n"

    # save output to file in this directory
    with open(os.path.join(current_dir, "add_genaccs.sh"), "w") as f:
        f.write(output)

    print(f"# [!] Run: sh add_genaccs.sh")
    print(
        f"# [!] THEN `junod collect-gentxs --gentx-dir {os.path.join(current_dir, 'gentx')} --home {current_dir}`"
    )
    print(f"# [!] THEN `junod validate-genesis --home {current_dir}`")
    print(f"# [!] THEN `code (LOCATION_OF_GENESIS_FILE), AND PUT ON MACHINES`")


if __name__ == "__main__":
    main()
