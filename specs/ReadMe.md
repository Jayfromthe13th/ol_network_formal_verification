# Formal Verification Specs for OL Network

This folder contains **formal specifications** for the `ol_account` module from the OL Network's Libra framework. These specifications were written using the **Move language** and ensure correctness, safety, and predictability of the following operations:

- **Invariant Management:** Ensuring consistent blockchain state.
- **Account Creation Safety:** Abort conditions for account creation.
- **Withdrawals with Slow Wallet Limits:** Restrictions on withdrawals.
- **Direct Coin Transfers:** Configuring and managing transfer permissions.

## How to Use These Specs

- **View the Full Spec:** Open `ol_account_spec.move` for the detailed specifications.
- **Reference Implementation:** These specs complement the OL Network’s code hosted [here](https://github.com/0LNetworkCommunity/libra-framework/tree/main/framework/libra-framework/sources).

## Related Contracts

These specs verify the behavior of the following contract:
- **`ol_framework::ol_account` Module:**  
  [View on GitHub](https://github.com/0LNetworkCommunity/libra-framework/tree/main/framework/libra-framework/sources/ol_account.move)

---

Feel free to explore these specifications, or use them as templates for your own Move-based smart contracts.
