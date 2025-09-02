circuit Hello :
  module Hello :
    input clock : Clock
    input reset : UInt<1>
    output io_led : UInt<1>

    reg cntReg : UInt<32>, clock with :
      reset => (UInt<1>("h0"), cntReg) @[Hello.scala 20:23]
    reg blkReg : UInt<1>, clock with :
      reset => (UInt<1>("h0"), blkReg) @[Hello.scala 21:23]
    node _cntReg_T = add(cntReg, UInt<1>("h1")) @[Hello.scala 23:20]
    node _cntReg_T_1 = tail(_cntReg_T, 1) @[Hello.scala 23:20]
    node _T = eq(cntReg, UInt<25>("h17d783f")) @[Hello.scala 24:15]
    node _blkReg_T = not(blkReg) @[Hello.scala 26:15]
    node _GEN_0 = mux(_T, UInt<1>("h0"), _cntReg_T_1) @[Hello.scala 23:10 24:28 25:12]
    node _GEN_1 = mux(_T, _blkReg_T, blkReg) @[Hello.scala 24:28 26:12 21:23]
    io_led <= blkReg @[Hello.scala 28:10]
    cntReg <= mux(reset, UInt<32>("h0"), _GEN_0) @[Hello.scala 20:{23,23}]
    blkReg <= mux(reset, UInt<1>("h0"), _GEN_1) @[Hello.scala 21:{23,23}]
