%lang starknet

from starkware.cairo.common.uint256 import Uint256

@contract_interface
namespace ICoupon {
    func get_default_value() -> (default_value: Uint256) {
    }

    func get_name() -> (name: felt) {
    }

    func verify_requirements(args_len: felt, args: felt*) -> (res: felt) {
    }
}
