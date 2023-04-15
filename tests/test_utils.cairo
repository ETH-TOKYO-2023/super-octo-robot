%lang starknet 
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.alloc import alloc

func pack_array(arr_len: felt, arr: felt*, first: felt, last: felt, allocd_len: felt, allocd: felt*) {
    alloc_locals;

    if (first == last) {
        return ();
    }

    let (local res: felt*) = alloc();
    assert allocd[allocd_len] = arr[first];

    return pack_array(arr_len, arr, first+1, last, allocd_len+1, allocd);
}

@external
func test_pack_array{syscall_ptr: felt*, range_check_ptr}() {
    alloc_locals;

    let (local arr: felt*) = alloc();
    %{
        segments.write_arg(ids.arr, [x for x in range(10)])
    %}

    let (local res: felt*) = alloc();
    pack_array(10, arr, 3, 7, 0, res);

    assert res[0] = 3;
    assert res[1] = 4;
    assert res[2] = 5;
    assert res[3] = 6;
    assert res[4] = 7;
    assert res[5] = 0;

    return ();
}
