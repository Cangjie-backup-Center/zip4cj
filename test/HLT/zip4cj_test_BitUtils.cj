//3rd_party_lib:zip4cj/build/release/zip4cj
//3rd_party_lib:zip4cj/build/release/charset
//3rd_party_lib:zip4cj/build/release/crypto4cj
import std.collection.*
import std.fs.*
import std.io.*
import std.unittest.*
import std.unittest.testmacro.*
import charset4cj.charset.*
import charset4cj.charset.encoding.*
import  zip4cj.*

@Test
public class BitUtilsTest {
    @TestCase
    func BitUtils01(): Unit {
        var bitset = BitUtils.isBitSet(0, 0)
        @Assert(bitset,false)
    }

    @TestCase
    func BitUtils02(): Unit {
        var bitset = BitUtils.isBitSet(125, 0)
        @Assert(bitset,true)
    }

    @TestCase
    func BitUtils03(): Unit {
        var setbit = BitUtils.setBit(125, 7)
        var unsetbit = BitUtils.unsetBit(15, 1)
        var isbitSet = BitUtils.isBitSet(125, 7)
        @Assert(setbit,253)
        @Assert(unsetbit,13)
        @Assert(isbitSet,false)
    }

    @TestCase
    func BitUtils04(): Unit {
        var setbit = BitUtils.setBit(125, 2147483647)
        var unsetbit = BitUtils.unsetBit(15, -2147483648)
        var isbitSet = BitUtils.isBitSet(125, 213647)
        println(setbit)
        println(unsetbit)
        println(isbitSet)
        @Assert(setbit,125)
        @Assert(unsetbit,14)
        @Assert(isbitSet,false)
    }
}
