%lang starknet

from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.math import assert_nn

from src.interfaces.IFactsRegistry import IFactsRegistry, StorageSlot
from starkware.cairo.common.alloc import alloc

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
func verify_requirements{syscall_ptr: felt*, range_check_ptr}(args_len: felt, args: felt*) -> (res: felt) {
    alloc_locals;

    local slot: StorageSlot = StorageSlot(
        word_1 = args[2],
        word_2 = args[3],
        word_3 = args[4],
        word_4 = args[5]
    );

    let (local proof_sizes_bytes: felt*) = alloc();
    let firsta = 4;
    let proof_sizes_bytes_len = args[6];
    let lasta = firsta+proof_sizes_bytes_len;
    pack_array(
        arr_len=args_len,
        arr=args,
        first=firsta,
        last=lasta,
        allocd_len=0,
        allocd=proof_sizes_bytes
    );

    let (local proof_sizes_words: felt*) = alloc();
    let firstb = lasta+2;
    let proof_sizes_words_len = args[lasta+1];
    let lastb = firstb + proof_sizes_words_len;
    pack_array(
        arr_len=args_len,
        arr=args,
        first=firstb,
        last=lastb,
        allocd_len=0,
        allocd=proof_sizes_bytes
    );

    let (local proofs_concat: felt*) = alloc();
    let firstc = lastb+2;
    let proofs_concat_len = args[lastb+1];
    let lastc = firstc + proofs_concat_len;
    pack_array(
        arr_len=args_len,
        arr=args,
        first=firstc,
        last=lastc,
        allocd_len=0,
        allocd=proof_sizes_bytes
    );

    let (value) = IFactsRegistry.get_storage_uint(
        contract_address=FACTS_REGISTRY_ADDRESS,
        block=args[0],
        account_160=args[1],
        slot=slot,
        proof_sizes_bytes_len=proof_sizes_bytes_len,
        proof_sizes_bytes=proof_sizes_bytes,
        proof_sizes_words_len=proof_sizes_words_len,
        proof_sizes_words=proof_sizes_words,
        proofs_concat_len=proofs_concat_len,
        proofs_concat=proofs_concat
    );
    return (res=1);
}

//func pack_array(arr_len: felt , arr: felt*, first: felt, last: felt, allocd_len: felt, allocd: felt*) -> (res_len: felt, res: felt*) {
    //alloc_locals;

    //if (first == last) {
        //return (res_len=allocd_len, res=allocd);
    //}

    //let (local res: felt*) = alloc();
    //allocd[allocd_len] = arr[first];

    //return pack_array(arr_len, arr, first+1, last, allocd_len+1, allocd);
//}

func pack_array(arr_len: felt, arr: felt*, first: felt, last: felt, allocd_len: felt, allocd: felt*) {
    alloc_locals;

    if (first == last) {
        return ();
    }

    let (local res: felt*) = alloc();
    assert allocd[allocd_len] = arr[first];

    return pack_array(arr_len, arr, first+1, last, allocd_len+1, allocd);
}
