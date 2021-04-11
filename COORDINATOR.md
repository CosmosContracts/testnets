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

### Learn more

- [Starport](https://github.com/tendermint/starport)
- [SPN](https://github.com/tendermint/spn)
- [Cosmos Network](https://cosmos.network)
- [Cosmos Community Discord](https://discord.com/invite/W8trcGV) (check out the #starport channel)
