module unit_testing_patterns::vault {

    public struct Vault has store, drop { balance: u64 }

    const ERR_NO_FUNDS: u64 = 200;

    public fun new(): Vault { Vault { balance: 0 } }

    public fun deposit(v: &mut Vault, amount: u64) { v.balance = v.balance + amount; }

    public fun withdraw(v: &mut Vault, amount: u64) {
        assert!(v.balance >= amount, ERR_NO_FUNDS);
        v.balance = v.balance - amount;
    }

    public fun balance(v: &Vault): u64 { v.balance }
}
