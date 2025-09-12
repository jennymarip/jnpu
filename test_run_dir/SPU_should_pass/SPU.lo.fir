circuit SPU :
  module SPU :
    input clock : Clock
    input reset : UInt<1>
    input io_left_in_0_0 : SInt<32>
    input io_left_in_0_1 : SInt<32>
    input io_left_in_0_2 : SInt<32>
    input io_left_in_0_3 : SInt<32>
    input io_left_in_1_0 : SInt<32>
    input io_left_in_1_1 : SInt<32>
    input io_left_in_1_2 : SInt<32>
    input io_left_in_1_3 : SInt<32>
    input io_up_in_0 : SInt<32>
    input io_up_in_1 : SInt<32>
    input io_weight_in_0 : SInt<32>
    input io_weight_in_1 : SInt<32>
    input io_index_in_0 : UInt<2>
    input io_index_in_1 : UInt<2>
    input io_weight_load_en : UInt<1>
    output io_weight_out_0 : SInt<32>
    output io_weight_out_1 : SInt<32>
    output io_index_out_0 : UInt<2>
    output io_index_out_1 : UInt<2>
    output io_down_out_0 : SInt<32>
    output io_down_out_1 : SInt<32>

    reg weight_buffer_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), weight_buffer_0) @[SPU.scala 18:28]
    reg weight_buffer_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), weight_buffer_1) @[SPU.scala 18:28]
    reg weight_index_0 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), weight_index_0) @[SPU.scala 19:27]
    reg weight_index_1 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), weight_index_1) @[SPU.scala 19:27]
    node _GEN_0 = mux(io_weight_load_en, io_weight_in_0, weight_buffer_0) @[SPU.scala 20:28 21:23 18:28]
    node _GEN_1 = mux(io_weight_load_en, io_weight_in_1, weight_buffer_1) @[SPU.scala 20:28 21:23 18:28]
    node _GEN_2 = mux(io_weight_load_en, io_index_in_0, weight_index_0) @[SPU.scala 20:28 22:22 19:27]
    node _GEN_3 = mux(io_weight_load_en, io_index_in_1, weight_index_1) @[SPU.scala 20:28 22:22 19:27]
    reg res_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), res_0) @[SPU.scala 24:18]
    reg res_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), res_1) @[SPU.scala 24:18]
    node _GEN_4 = validif(eq(UInt<1>("h0"), weight_index_0), io_left_in_0_0) @[SPU.scala 26:{36,36}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), weight_index_0), io_left_in_0_1, _GEN_4) @[SPU.scala 26:{36,36}]
    node _GEN_6 = mux(eq(UInt<2>("h2"), weight_index_0), io_left_in_0_2, _GEN_5) @[SPU.scala 26:{36,36}]
    node _GEN_7 = mux(eq(UInt<2>("h3"), weight_index_0), io_left_in_0_3, _GEN_6) @[SPU.scala 26:{36,36}]
    node _io_left_in_0_weight_index_0 = _GEN_7 @[SPU.scala 26:36]
    node _res_0_T = mul(weight_buffer_0, _io_left_in_0_weight_index_0) @[SPU.scala 26:36]
    node _res_0_T_1 = add(_res_0_T, io_up_in_0) @[SPU.scala 26:69]
    node _res_0_T_2 = tail(_res_0_T_1, 1) @[SPU.scala 26:69]
    node _res_0_T_3 = asSInt(_res_0_T_2) @[SPU.scala 26:69]
    node _GEN_8 = validif(eq(UInt<1>("h0"), weight_index_1), io_left_in_1_0) @[SPU.scala 26:{36,36}]
    node _GEN_9 = mux(eq(UInt<1>("h1"), weight_index_1), io_left_in_1_1, _GEN_8) @[SPU.scala 26:{36,36}]
    node _GEN_10 = mux(eq(UInt<2>("h2"), weight_index_1), io_left_in_1_2, _GEN_9) @[SPU.scala 26:{36,36}]
    node _GEN_11 = mux(eq(UInt<2>("h3"), weight_index_1), io_left_in_1_3, _GEN_10) @[SPU.scala 26:{36,36}]
    node _io_left_in_1_weight_index_1 = _GEN_11 @[SPU.scala 26:36]
    node _res_1_T = mul(weight_buffer_1, _io_left_in_1_weight_index_1) @[SPU.scala 26:36]
    node _res_1_T_1 = add(_res_1_T, io_up_in_1) @[SPU.scala 26:69]
    node _res_1_T_2 = tail(_res_1_T_1, 1) @[SPU.scala 26:69]
    node _res_1_T_3 = asSInt(_res_1_T_2) @[SPU.scala 26:69]
    io_weight_out_0 <= weight_buffer_0 @[SPU.scala 28:19]
    io_weight_out_1 <= weight_buffer_1 @[SPU.scala 28:19]
    io_index_out_0 <= weight_index_0 @[SPU.scala 29:18]
    io_index_out_1 <= weight_index_1 @[SPU.scala 29:18]
    io_down_out_0 <= res_0 @[SPU.scala 30:17]
    io_down_out_1 <= res_1 @[SPU.scala 30:17]
    weight_buffer_0 <= _GEN_0
    weight_buffer_1 <= _GEN_1
    weight_index_0 <= _GEN_2
    weight_index_1 <= _GEN_3
    res_0 <= asSInt(bits(_res_0_T_3, 31, 0)) @[SPU.scala 26:16]
    res_1 <= asSInt(bits(_res_1_T_3, 31, 0)) @[SPU.scala 26:16]
