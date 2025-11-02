module unit_testing_patterns::math_tests {
    use unit_testing_patterns::math;
    #[test] 
    public fun add_works() { 
        let r = math::add(2,3); assert!(r==5, 1); 
    }
    
    #[test] 
    #[expected_failure] 
    public fun div_zero_fails() { 
        let _ = math::safe_div(1,0); 
    }
    
    #[test] 
    public fun div_ok() { 
        let r = math::safe_div(6,2); assert!(r==3, 2); 
    }
}
