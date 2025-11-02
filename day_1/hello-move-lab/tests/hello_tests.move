module hello_move_lab::hello_tests {
    use std::string;
    use hello_move_lab::hello;

    /// Unit test for greet()
    #[test]
    public fun test_greet() {
        let s = hello::greet();
        assert!(string::length(&s) > 0, 1);
    }

    /// Unit test for add()
    #[test]
    public fun test_add() {
        let r = hello::add(2, 3);
        assert!(r == 5, 2);
    }
}
