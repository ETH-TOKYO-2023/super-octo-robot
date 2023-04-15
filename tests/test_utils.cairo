%lang starknet 
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

@external
func test_pack_array{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;

    let (local arr: felt*) = alloc();
    assert arr[0] = 0;
    assert arr[1] = 1;
    assert arr[2] = 2;
    assert arr[3] = 3;
    assert arr[4] = 4;
    assert arr[5] = 0;
    assert arr[6] = 6;
    assert arr[7] = 7;
    assert arr[8] = 8;
    assert arr[9] = 9;

    let (local res: felt*) = alloc();
    pack_array(10, arr, 3, 7, 0, res);

    assert res[0] = 3;
    assert res[1] = 4;
    assert res[2] = 0;
    assert res[3] = 6;
    assert res[4] = 7;

    return ();
}

func pack_array(arr_len: felt, arr: felt*, first: felt, last: felt, allocd_len: felt, allocd: felt*) {
    alloc_locals;

    if (first == last) {
        return ();
    }

    let (local res: felt*) = alloc();
    assert allocd[allocd_len] = arr[first];

    return pack_array(arr_len, arr, first+1, last, allocd_len+1, allocd);
}
