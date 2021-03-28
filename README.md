# Juno Testnets

* [Testnet 1](#testnet-1)

## Setup

You will need [Starport](https://github.com/tendermint/starport) installed. We'll using SPN to deploy the chain and connect validators. SPN is being actively developed, please, build Starport from source and use `develop` branch.

### Install and build latest Starport:
**Prerequisites:** If you want to install Starport locally, make sure to have [Golang >=1.14](https://golang.org/). The latest version of Starport also requires [Protocol Buffer compiler](https://grpc.io/docs/protoc-installation/) to be installed. [Node.js >=12.19.0](https://nodejs.org/) is used to build the welcome screen, block explorer and to run the web scaffold.

#### Build from source

Starport uses [Git LFS](https://git-lfs.github.com/). **Please make sure that it is installed before cloning Starport.**

If you have installed Git LFS after cloning Starport, checkout to your preferred branch to trigger a pull for large files or run `git lfs pull`.

```sh
git clone https://github.com/tendermint/starport --depth=1
cd starport && make
```

This will build and install `starport` binary into `$GOBIN`.

Note: When building from source, it is important to have your `$GOPATH` set correctly.  When in doubt, the following should do:

```sh
mkdir ~/go
export GOPATH=~/go
```

### Minimum hardware requirements
- 2GB RAM
- 25GB of disk space
- 1.4 GHz CPU

## Testnet 1

The first testnet will test using SPN to deploy the chain and connect validators.

The goal is simply to get the chain started and assess the viability of using SPN.

### Parameters

* `chainID`: `juno-testnet-1`
* `sourceURL`: https://github.com/CosmosContracts/Juno
* *Start time TBD*

### Joining as a validator

Run the following command from a server to propose yourself as a validator:

```
starport network chain join [chainID]
```

Follow the prompts to provide information about the validator. Starport will download the source code of the blockchain node, build, initialize and create and send two proposals to SPN: to add an account and to add a validator with self-delegation. By running a `join` command you act as a "validator".

By default, a coordinator does not propose themselves as a validator. To do so, run `join` command and your proposals will be automatically approved.

#### Starting your blockchain node

Once validator proposals have been accepted, run the following command to start a blockchain node:

```
starport network chain start [chainID]
```

This command will use SPN to create a correct genesis file, configure and launch your blockchain node. Once the node is started and the required number of validators are online, you will see output with incrementing block height number, which means that the blockchain has been successfully started.

### Coordinator instructions

**NOTE: these steps should be done only by the testnet coordinator, if you're a validator skip these steps.**

The testnet coordinator will configure the initial chain for launch, and accept proposals from validators seek to join.

#### Initiating a blockchain launch

To initiate a blockchain launch run the following command:

```
starport network chain create [chainID] [sourceURL]
```

`chainID` is a string that uniquely identifies your blockchain on SPN. `sourceURL` is a URL that can be used to clone the repository containing a Cosmos SDK blockchain node (for example, `https://github.com/tendermint/spn`). By running the `create` command you act as a "coordinator" and initiate the launch of a blockchain.

#### Listing pending proposals

```
starport network proposal list [chainID]
```

This command lists all proposals. To filter the list of proposals use the `--status` flag (possible values are: `approved`, `pending` and `rejected`). Each proposal has a `proposalID` (integer, unique to the chain), this ID is used to approve and reject a proposal.

#### Accepting and rejecting proposals

As a coordinator run the following command to approve proposals:

```
starport network proposal approve [chainID] 1,4,5,6
```

Replace comma-separated values with a list of `proposalID` being accepted. Replace `approve` with `reject` to reject proposals instead.

### Learn more

* [Starport](https://github.com/tendermint/starport)
* [Cosmos Network](https://cosmos.network)
* [Cosmos Community Discord](https://discord.com/invite/W8trcGV) (check out the #starport channel)
