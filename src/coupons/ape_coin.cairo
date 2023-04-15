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
func verify_requirements(args_len: felt, args: felt*) -> (res: felt) {
    alloc_locals;

    local slot: StorageSlot;
    slot.word_1 = args[3];
    slot.word_2 = args[4];
    slot.word_3 = args[5];
    slot.word_4 = args[6];

    let (local proof_sizes_bytes: felt*) = alloc();
    //let (local proof_sizes_bytes_len: felt, proof_sizes_bytes: felt*) = pack_array(args_len, args, 0, 0+args[7], 0, a);

    //let (value) = IFactsRegistry.get_storage_uint(
        //contract_address=FACTS_REGISTRY_ADDRESS,
        //block=args[1],
        //account_160=args[2],
        //slot=slot,
        //proof_sizes_bytes_len=args[7],
        //proof_sizes_bytes=args[8],
        //proof_sizes_words_len=args[9],
        //proof_sizes_words=args[10],
        //proofs_concat_len=args[11],
        //proofs_concat=args[12]
    //);
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
