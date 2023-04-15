%lang starknet 
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@contract_interface
namespace Factory {
    func add_coupon(coupon_address: felt) {
    }

    func mint_coupon(coupon_address: felt, verify_requirements_len: felt, verify_requirements: felt*) {
    }
}

@external
func test_add_coupon{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;

    local contract_address: felt;
    %{ ids.contract_address = deploy_contract("./src/factory.cairo", [123, 12, 18]).contract_address %}

    Factory.add_coupon(contract_address=contract_address, coupon_address=1);
    Factory.add_coupon(contract_address=contract_address, coupon_address=2);
    Factory.add_coupon(contract_address=contract_address, coupon_address=3);
    Factory.add_coupon(contract_address=contract_address, coupon_address=4);

    return ();
}

@external
func test_mint_coupon{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;

    local factory_address: felt;
    local coupon_address: felt;
    %{ 
          ids.factory_address = deploy_contract("./src/factory.cairo", [123, 12, 18]).contract_address 
          ids.coupon_address = deploy_contract("./src/coupons/mock_coupon.cairo", []).contract_address 
    %}

    Factory.add_coupon(contract_address=factory_address, coupon_address=coupon_address);

    let (local arr) = alloc();
    Factory.mint_coupon(contract_address=factory_address, coupon_address=coupon_address, verify_requirements_len=0, verify_requirements=arr);

    return ();
}

@external
func test_mint_coupon_revert{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;

    local factory_address: felt;
    %{ 
          ids.factory_address = deploy_contract("./src/factory.cairo", [123, 12, 18]).contract_address 
    %}

    Factory.add_coupon(contract_address=factory_address, coupon_address=1);

    let (local arr) = alloc();
    %{ expect_revert() %}
    Factory.mint_coupon(contract_address=factory_address, coupon_address=1, verify_requirements_len=0, verify_requirements=arr);

    return ();
}
