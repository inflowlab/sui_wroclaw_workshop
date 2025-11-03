module unit_testing_patterns::vault_tests {
    use unit_testing_patterns::vault::{Self, Vault};

    #[test] 
    public fun deposit_then_withdraw() {
        let mut v = vault::new();
        vault::deposit(&mut v, 10);
        assert!(vault::balance(&v) == 10, 1);
        vault::withdraw(&mut v, 7);
        assert!(vault::balance(&v) == 3, 2);
    }

    #[test] 
    #[expected_failure] 
    public fun withdraw_over_balance_aborts() {
        let mut v = vault::new();
        vault::withdraw(&mut v, 1);
    }
}
