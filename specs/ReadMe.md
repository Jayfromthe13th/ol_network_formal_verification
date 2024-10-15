# Formal Verification Specs for `ol_account` Module

This folder contains **formal specifications** for the [`ol_account`](https://github.com/0LNetworkCommunity/libra-framework/blob/main/framework/libra-framework/sources/ol_sources/ol_account.move) module from the **OL Network's Libra framework**. These specifications are written using the **Move language** to ensure correctness, safety, and expected behavior of critical functions in the contract.

## 🔍 Overview of Specs

This formal verification ensures:

- **Invariant Management**: Verifying that the blockchain’s state remains consistent during key operations.
- **Account Creation Safety**: Preventing unauthorized or misconfigured account creation.
- **Withdrawal Restrictions**: Enforcing limits on withdrawals, particularly with **slow wallets**.
- **Direct Coin Transfers Configuration**: Managing transfer permissions safely.

These specifications allow the contract to behave **predictably** under all scenarios and prevent vulnerabilities by defining preconditions, postconditions, and abort conditions.

---

## 🛠 Verified Functions

### 1. **`withdraw`**
- **Purpose**: Ensures that withdrawals comply with account and slow wallet limits.
- **Verification**:
  - Abort if the withdrawal amount is `0`.
  - Abort if the sender has insufficient balance.
  - Abort if the unlocked amount in a slow wallet is insufficient.
  - Ensure the correct amount of coins is returned.

---

### 2. **`CreateAccountAbortsIf` Schema**
- **Purpose**: Prevents unsafe account creation.
- **Verification**:
  - Abort if the account already exists.
  - Abort if the `auth_key` length is not exactly 32 bytes.
  - Abort if the `auth_key` belongs to a reserved address.

---

### 3. **`set_allow_direct_coin_transfers`**
- **Purpose**: Controls whether an account can receive coins directly.
- **Verification**:
  - Abort if the account configuration is missing and an event handle needs to be created.
  - Ensure the configuration is updated correctly.

---

### 4. **`can_receive_direct_coin_transfers`**
- **Purpose**: Checks if an account is allowed to receive direct coin transfers.
- **Verification**:
  - Ensure the result reflects the account's configuration.
  - If no configuration exists, direct transfers are allowed by default.

---

## 📝 How to Use

1. Review the full spec file: [`ol_account_spec.move`](./ol_account_spec.move).
2. Compare the specs with the original [OL Network `ol_account` contract](https://github.com/0LNetworkCommunity/libra-framework/blob/main/framework/libra-framework/sources/ol_sources/ol_account.move).
3. Use these specs as a template or reference for writing secure Move-based contracts.

---

## 🔗 Related Contracts

This formal verification applies to the following contract:

- **`ol_account` Module**  
  [View Contract on GitHub](https://github.com/0LNetworkCommunity/libra-framework/blob/main/framework/libra-framework/sources/ol_sources/ol_account.move)

---

## 💡 Why Formal Verification?

Formal verification ensures that **smart contracts behave correctly** under all conditions, reducing the risk of bugs, exploits, and misconfigurations. These specs demonstrate:

- **Secure Account Management**: Avoiding unsafe account creation.
- **Correct Coin Handling**: Preventing unauthorized withdrawals and mismanagement.
- **Predictable Permissions**: Safely managing transfer permissions.

---

