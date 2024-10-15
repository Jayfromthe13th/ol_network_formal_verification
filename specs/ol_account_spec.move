// ol_account_spec.move

module ol_framework::ol_account {

    // Module-level invariants to ensure blockchain state consistency.
    spec module {
        pragma verify = true;
        invariant [suspendable] chain_status::is_operating() 
            ==> exists<libra_coin::FinalMint>(@diem_framework);
        invariant [suspendable] chain_status::is_operating() 
            ==> exists<coin::CoinInfo<LibraCoin>>(@diem_framework);
    }

    // Abort conditions for account creation.
    spec schema CreateAccountAbortsIf {
        auth_key: address;
        aborts_if exists<account::Account>(auth_key);  // Abort if account already exists.
        aborts_if length_judgment(auth_key);  // Abort if auth_key is not 32 bytes.
        aborts_if auth_key == @vm_reserved || auth_key == @diem_framework || auth_key == @diem_token;
    }

    // Check if the auth key is 32 bytes.
    spec fun length_judgment(auth_key: address): bool {
        use std::bcs;
        let authentication_key = bcs::to_bytes(auth_key);
        len(authentication_key) != 32
    }

    // Withdraw function ensuring respect for slow wallet limits.
    spec withdraw(sender: &signer, amount: u64): Coin<LibraCoin> {
        include AssumeCoinRegistered;

        let account_addr = signer::address_of(sender);
        aborts_if amount == 0;

        let coin_store = global<coin::CoinStore<LibraCoin>>(account_addr);
        let balance = coin_store.coin.value;

        aborts_if balance < amount;

        let slow_store = global<slow_wallet::SlowWallet>(account_addr);
        aborts_if exists<slow_wallet::SlowWallet>(account_addr) &&
            slow_store.unlocked < amount;

        ensures result == Coin<LibraCoin>{value: amount};
    }

    // Schema to ensure the account is registered for LibraCoin.
    spec schema AssumeCoinRegistered {
        sender: &signer;
        let account_addr = signer::address_of(sender);
        aborts_if !coin::is_account_registered<LibraCoin>(account_addr);
    }

    // Ensure account existence.
    spec assert_account_exists(addr: address) {
        aborts_if !account::exists_at(addr);
    }

    // Ensure account registration for gas (LibraCoin).
    spec assert_account_is_registered_for_gas(addr: address) {
        aborts_if !account::exists_at(addr);
        aborts_if !coin::is_account_registered<LibraCoin>(addr);
    }

    // Spec for setting direct coin transfer permissions.
    spec set_allow_direct_coin_transfers(account: &signer, allow: bool) {
        let addr = signer::address_of(account);
        include !exists<DirectTransferConfig>(addr) 
            ==> account::NewEventHandleAbortsIf;
    }

    // Check if an account can receive direct coin transfers.
    spec can_receive_direct_coin_transfers(account: address): bool {
        aborts_if false;
        ensures result == (
            !exists<DirectTransferConfig>(account) ||
            global<DirectTransferConfig>(account).allow_arbitrary_coin_transfers
        );
    }
}

