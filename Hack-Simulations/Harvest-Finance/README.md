## Hack Analysis
**Date**: October 26, 2020
**Amount** Lost: $34 Million

## Agent-Based Simulations for Exploit:
**Agents:**
Attacker: This agent would represent the attacker and their actions, including flash loan acquisition, asset swaps, and fUSDT deposits/withdrawals.

**Observers:**
Price of the Tokens: This agent would monitor the balance of the tokens of attacker during the whole exploit. 

**Scenario:**
Attacker calling the Exploit contract. 

**Assertions:**
Assertions basically checks if the exploit is sucessful and checks the price of tokens is inflated/ deflated during the hack.  

### About Harvest Finance:
Harvest is a type of yield farming protocol. It gathers yields from various lending protocols and optimizes for the maximum gain to return to depositors. 

### Arbitrage Protection Threshold:
Harvest Finance implemented an arbitrage check within its strategies.
This check triggered if the potential arbitrage opportunity exceeded a 3% threshold.
However, during the attack, the attacker exploited an arbitrage opportunity for 1% with the USDC-FUSDC pair.
As the exploit fell below the 3% threshold, the arbitrage check failed to trigger, allowing the attacker to proceed.

### Attack Technique:
The attacker exploited arbitrage opportunities within the Curve.fi Y pool using a flash loan. By strategically swapping assets and manipulating the pool's price dynamics, the attacker was able to withdraw more USDT than deposited, generating significant profits.
Root Cause: 
The exploit was rooted in Harvest Finance's price calculation mechanism for LP deposits and withdrawals. This mechanism, combined with the inherent impermanent loss within the Curve.fi Y pool, created a vulnerability that the attacker exploited.


### Exploit Steps:
- In a rapid sequence, the attacker conducted multiple transactions in a short period of time, targeting Harvest Finance's USDC and USDT vaults.
- To gain deeper insights into the attack, let's delve into the details of the below transaction: 0x9d093325272701d63fdafb0af2d89c7e23eaf18be1a51c580d9bce89987a2dc1
- Initial Fund for Attack: The attacker initially transferred 10 ETH from Tornado cash to his EOA and funded his attack contract with 10.69M USDT & 11.435M USDC. 
- Flash Loan Acquisition: Next, The attacker took a 50M USDT flash loan from the Uniswap v2 USDT-WETH pair. This provided the necessary capital to initiate the exploit.
- USDC Swap: The attacker swapped 11.425M USDC for 11.407M USDT, causing an increase in the USDT price within the pool.
- fUSDT Deposit: The attacker deposited 60.66M USDT into the Harvest's fUSDT pool, receiving 71.66M fUSDT tokens.
- USDT Swap Reversal: The attacker swapped the 11.407M USDT back to USDC, decreasing the USDT price within the pool.
- fUSDT Withdrawal: The attacker withdrew their fUSDT tokens, receiving 61.1M USDT, exceeding the initial deposit of 60.66M USDT resulting in a profit of approximately 0.5M. This discrepancy arose from the manipulated USDT price within the pool.
- Profit Maximization: The attacker repeated these steps multiple times, accumulating a total profit of $24M from the exploit.

Through a carefully orchestrated series of actions, the attacker capitalized on vulnerabilities within the Y pool, exploiting market dynamics and impermanent loss to generate substantial profits.

### Aftermath:
**Price Drop**: This manipulation caused a significant price drop: fUSDT fell by 13.7% and $FARM by 67% within two hours.
Profits and Losses: The attack resulted in a total loss of approximately $33.8 million. While the attacker made significant gains, LPs and Harvest developers also received a portion of the profit.
Transferring Funds: The attacker concluded the attack by transferring 13,000,000 USDC and 11,000,000 USDT from the attacking contract to address 0x3811765a53c3188c24d412daec3f60faad5f119b.
Returning Funds: Within this transaction, 1,761,898.396474 USDC and 718,914.048541 USDT were unexpectedly returned to the Deployer.

---

