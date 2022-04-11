## Stakedrop remediation

We want to run through a few scenarios, so we will likely need to restart the network a few times.

It will be critical to make sure we can easily roll back to our genesis state and start over.

We have some time here, but we need to test at least three scenarios.

High level, we need to test:

```
- withdrawal address: withdraw all funds

- gov: send x funds to address
- gov: send all funds to address
- gov: burn all funds
```

### Scenario 1: Funds Remain Delegated

This is the simplest scenario.

#### Prep

1. Using CCN_SIM account, I delegate to each of the validators
1. The CCN_SIM account, begins accruing rewards
1. The CCN_SIM account, still has available balance

#### Execute

1. We propose the upgrade on chain
1. We prepare our machines for the upgrade
1. The upgrade executes, we begin producing blocks

#### Review

1. We observe that the stakedrop remediated account has no balance
1. We observe that the Unity Prop Smart Contract address has a balance equal to the stakedrop remediation

### Scenario 2: Most Funds Remain Delegated, Some Funds Undelegate

This is a slight modification, but will test if the upgrade handler is handling unbondings.

#### Prep

1. Using CCN_SIM account, I delegate to each of the validators
1. The CCN_SIM account, begins accruing rewards
1. The CCN_SIM account, still has available balance
1. Using CCN_SIM account, I undelegate from one of the validators

#### Execute

1. We propose the upgrade on chain
1. We prepare our machines for the upgrade
1. The upgrade executes, we begin producing blocks

#### Review

1. We observe that the stakedrop remediated account has no balance
1. We observe that the Unity Prop Smart Contract address has a balance equal to the stakedrop remediation

### Scenario 3: Most Funds Remain Delegated, Some Funds Redelegate

This is a slight modification, but will test if the upgrade handler is handling redelegation.

#### Prep

1. Using CCN_SIM account, I delegate to each of the validators
1. The CCN_SIM account, begins accruing rewards
1. The CCN_SIM account, still has available balance
1. Using CCN_SIM account, I redelegate from one of the validators to another validator

#### Execute

1. We propose the upgrade on chain
1. We prepare our machines for the upgrade
1. The upgrade executes, we begin producing blocks

#### Review

1. We observe that the stakedrop remediated account has no balance
1. We observe that the Unity Prop Smart Contract address has a balance equal to the stakedrop remediation

## Next Steps

Should we find an issue in one of the scenarios, we'll need to perform an update and run through them again.

Once we have complete success in all three scenarios, we can declare the code safe for mainnet.

We may wish to run this again following Lupercalia Phase1 upgrade.