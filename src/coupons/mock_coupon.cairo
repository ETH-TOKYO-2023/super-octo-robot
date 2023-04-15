%lang starknet

from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math import assert_nn

const APE_ADDRESS = 1;
const FACTS_REGISTRY_ADDRESS = 1;

@view
func get_default_value() -> (res: Uint256) {
    alloc_locals;

    local value: Uint256 = Uint256(
        low=100,
        high=0
    );

    return (res=value);
}

@view
func verify_requirements(args_len: felt, args: felt*) -> (res: felt) {
    return (res=1);
}
