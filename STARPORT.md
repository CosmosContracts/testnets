# Starport testing

You can use Starport to easily spin up new instances of Juno for quick testing.

## Coordinator instructions

**NOTE: these steps should be done only by the testnet coordinator, if you're a validator skip these steps.**

The testnet coordinator will configure the initial chain for launch, and accept proposals from validators seek to join.

#### Initiating a blockchain launch

To initiate a blockchain launch run the following command:

```
starport network chain create [chainID] [sourceURL] --nightly
```

`chainID` is a string that uniquely identifies your blockchain on SPN. `sourceURL` is a URL that can be used to clone the repository containing a Cosmos SDK blockchain node (for example, `https://github.com/tendermint/spn`). By running the `create` command you act as a "coordinator" and initiate the launch of a blockchain.

#### Listing pending proposals

```
starport network proposal list [chainID] --nightly
```

This command lists all proposals. To filter the list of proposals use the `--status` flag (possible values are: `approved`, `pending` and `rejected`). Each proposal has a `proposalID` (integer, unique to the chain), this ID is used to approve and reject a proposal.

#### Accepting and rejecting proposals

As a coordinator run the following command to approve proposals:

```
starport network proposal approve [chainID] 1,4,5,6 --nightly
```

Replace comma-separated values with a list of `proposalID` being accepted. Replace `approve` with `reject` to reject proposals instead.

### Joining as a validator

**IMPORTANT: Be sure to run the following on the machine you'll use for the testnet.**

Run the following command from a server to propose yourself as a validator:

```
starport network chain join [chainID] --nightly
```

Follow the prompts to provide information about the validator. Starport will download the source code of the blockchain node, build, initialize and create and send two proposals to SPN: to add an account and to add a validator with self-delegation. By running a `join` command you act as a "validator". When filling out the required parameters ensure to include the **'stake'** word after the required values for the inputs to be accepted. If the terminal gets an error or hangs then you can also try: `starport network chain join [chainID] --nightly --keyring-backend "test"`

Be sure to write down your seed phrase, you'll need to add your key to junod to interact with the chain.

#### Starting your blockchain node

Run the following command to start your blockchain node:

```
starport network chain start [chainID] --nightly
```

This command will use SPN to create a correct genesis file, configure and launch your blockchain node. Once the node is started and the required number of validators are online, you will see output with incrementing block height number, which means that the blockchain has been successfully started.

NOTE: Make sure `build_tags` includes "faucet", which is required for testnet.

### Learn more

- [Starport](https://github.com/tendermint/starport)
- [SPN](https://github.com/tendermint/spn)
- [Cosmos Network](https://cosmos.network)
- [Cosmos Community Discord](https://discord.com/invite/W8trcGV) (check out the #starport channel)
