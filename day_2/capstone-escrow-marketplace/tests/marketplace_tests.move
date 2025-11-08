module market::marketplace_tests {
    use sui::test_scenario;
    use std::string;
    use market::marketplace;

    /// NOTE: Coin<SUI> creation & funding vary by framework/test helpers. This is a scaffold.
    #[test]
    public fun list_then_buy_and_confirm_skeleton() {
        // let sc = test_scenario::begin();
        // let seller = test_scenario::create_sender(&sc);
        // let buyer  = test_scenario::create_sender(&sc);

        // // TX1: seller lists
        // test_scenario::next_tx(&sc, seller);
        // marketplace::create_listing(string::utf8(b"Trezor Model T"), 1, &mut test_scenario::ctx(&sc));

        // // TODO: fetch Listing, mint a Coin<SUI> with value 1 for buyer, call buy, then confirm_delivery.

        // test_scenario::end(sc);
    }
}