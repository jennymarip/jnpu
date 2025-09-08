circuit SPU :
  module SPU :
    input clock : Clock
    input reset : UInt<1>
    input io_left_in_0_data_0 : SInt<32>
    input io_left_in_0_data_1 : SInt<32>
    input io_left_in_1_data_0 : SInt<32>
    input io_left_in_1_data_1 : SInt<32>
    input io_up_in_0 : SInt<32>
    input io_up_in_1 : SInt<32>
    input io_weight_in_0 : SInt<32>
    input io_weight_in_1 : SInt<32>
    input io_index_in_0 : UInt<2>
    input io_index_in_1 : UInt<2>
    output io_down_out_0 : SInt<32>
    output io_down_out_1 : SInt<32>
    output io_weight_buffer_out_0 : SInt<32>
    output io_weight_buffer_out_1 : SInt<32>

    reg weight_buffer_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), weight_buffer_0) @[SPU.scala 14:28]
    reg weight_buffer_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), weight_buffer_1) @[SPU.scala 14:28]
    reg weight_index_0 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), weight_index_0) @[SPU.scala 16:27]
    reg weight_index_1 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), weight_index_1) @[SPU.scala 16:27]
    reg res_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), res_0) @[SPU.scala 19:18]
    reg res_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), res_1) @[SPU.scala 19:18]
    node _res_0_T = bits(weight_index_0, 0, 0)
    node _GEN_0 = validif(eq(UInt<1>("h0"), _res_0_T), io_left_in_0_data_0) @[SPU.scala 21:{36,36}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), _res_0_T), io_left_in_0_data_1, _GEN_0) @[SPU.scala 21:{36,36}]
    node _io_left_in_0_data_res_0_T = _GEN_1 @[SPU.scala 21:36]
    node _res_0_T_1 = mul(weight_buffer_0, _io_left_in_0_data_res_0_T) @[SPU.scala 21:36]
    node _res_0_T_2 = add(_res_0_T_1, io_up_in_0) @[SPU.scala 21:74]
    node _res_0_T_3 = tail(_res_0_T_2, 1) @[SPU.scala 21:74]
    node _res_0_T_4 = asSInt(_res_0_T_3) @[SPU.scala 21:74]
    node _res_1_T = bits(weight_index_1, 0, 0)
    node _GEN_2 = validif(eq(UInt<1>("h0"), _res_1_T), io_left_in_1_data_0) @[SPU.scala 21:{36,36}]
    node _GEN_3 = mux(eq(UInt<1>("h1"), _res_1_T), io_left_in_1_data_1, _GEN_2) @[SPU.scala 21:{36,36}]
    node _io_left_in_1_data_res_1_T = _GEN_3 @[SPU.scala 21:36]
    node _res_1_T_1 = mul(weight_buffer_1, _io_left_in_1_data_res_1_T) @[SPU.scala 21:36]
    node _res_1_T_2 = add(_res_1_T_1, io_up_in_1) @[SPU.scala 21:74]
    node _res_1_T_3 = tail(_res_1_T_2, 1) @[SPU.scala 21:74]
    node _res_1_T_4 = asSInt(_res_1_T_3) @[SPU.scala 21:74]
    io_down_out_0 <= res_0 @[SPU.scala 23:17]
    io_down_out_1 <= res_1 @[SPU.scala 23:17]
    io_weight_buffer_out_0 <= weight_buffer_0 @[SPU.scala 15:26]
    io_weight_buffer_out_1 <= weight_buffer_1 @[SPU.scala 15:26]
    weight_buffer_0 <= io_weight_in_0 @[SPU.scala 17:19]
    weight_buffer_1 <= io_weight_in_1 @[SPU.scala 17:19]
    weight_index_0 <= io_index_in_0 @[SPU.scala 18:18]
    weight_index_1 <= io_index_in_1 @[SPU.scala 18:18]
    res_0 <= asSInt(bits(_res_0_T_4, 31, 0)) @[SPU.scala 21:16]
    res_1 <= asSInt(bits(_res_1_T_4, 31, 0)) @[SPU.scala 21:16]
