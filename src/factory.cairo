%lang starknet
//import assert_nn
from starkware.cairo.common.math import assert_nn
from starkware.cairo.common.cairo_builtins import HashBuiltin

from src.interfaces.ICoupon import ICoupon

@storage_var
func coupons(coupon_address: felt) -> (res: felt) {
}

@external
func add_coupon{syscall_ptr: felt*, pedersen_ptr:HashBuiltin*, range_check_ptr}(coupon_address: felt) {
  coupons.write(coupon_address, 1);

  return ();
}

@external 
func mint_coupon{syscall_ptr: felt*, pedersen_ptr:HashBuiltin*, range_check_ptr}(coupon_address: felt) {
  let (res) = coupons.read(coupon_address);
  assert_nn(res);

  let (valid) = ICoupon.verify_requirements(contract_address=coupon_address);
  assert_nn(valid);


  //TODO mint coupon

  return ();
}

//@external
//func increase_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    //amount: felt
//) {
    //with_attr error_message("Amount must be positive. Got: {amount}.") {
        //assert_nn(amount);
    //}

    //let (res) = balance.read();
    //balance.write(res + amount);
    //return ();
//}

//@view
//func get_balance{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (res: felt) {
    //let (res) = balance.read();
    //return (res,);
//}

//@constructor
//func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() {
    //balance.write(0);
    //return ();
//}
