circuit vegeta_sa :
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

  module SPE :
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
    input io_up_in_0_0 : SInt<32>
    input io_up_in_0_1 : SInt<32>
    input io_up_in_1_0 : SInt<32>
    input io_up_in_1_1 : SInt<32>
    input io_weight_in_0_0 : SInt<32>
    input io_weight_in_0_1 : SInt<32>
    input io_weight_in_1_0 : SInt<32>
    input io_weight_in_1_1 : SInt<32>
    input io_index_in_0_0 : UInt<2>
    input io_index_in_0_1 : UInt<2>
    input io_index_in_1_0 : UInt<2>
    input io_index_in_1_1 : UInt<2>
    input io_weight_load_en : UInt<1>
    output io_right_out_0_0 : SInt<32>
    output io_right_out_0_1 : SInt<32>
    output io_right_out_0_2 : SInt<32>
    output io_right_out_0_3 : SInt<32>
    output io_right_out_1_0 : SInt<32>
    output io_right_out_1_1 : SInt<32>
    output io_right_out_1_2 : SInt<32>
    output io_right_out_1_3 : SInt<32>
    output io_weight_out_0_0 : SInt<32>
    output io_weight_out_0_1 : SInt<32>
    output io_weight_out_1_0 : SInt<32>
    output io_weight_out_1_1 : SInt<32>
    output io_index_out_0_0 : UInt<2>
    output io_index_out_0_1 : UInt<2>
    output io_index_out_1_0 : UInt<2>
    output io_index_out_1_1 : UInt<2>
    output io_down_out_0_0 : SInt<32>
    output io_down_out_0_1 : SInt<32>
    output io_down_out_1_0 : SInt<32>
    output io_down_out_1_1 : SInt<32>

    inst SPUs_0 of SPU @[SPE.scala 19:49]
    inst SPUs_1 of SPU @[SPE.scala 19:49]
    reg rigth_out_buffer_0_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_0) @[SPE.scala 30:31]
    reg rigth_out_buffer_0_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_1) @[SPE.scala 30:31]
    reg rigth_out_buffer_0_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_2) @[SPE.scala 30:31]
    reg rigth_out_buffer_0_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_3) @[SPE.scala 30:31]
    reg rigth_out_buffer_1_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_0) @[SPE.scala 30:31]
    reg rigth_out_buffer_1_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_1) @[SPE.scala 30:31]
    reg rigth_out_buffer_1_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_2) @[SPE.scala 30:31]
    reg rigth_out_buffer_1_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_3) @[SPE.scala 30:31]
    io_right_out_0_0 <= rigth_out_buffer_0_0 @[SPE.scala 32:18]
    io_right_out_0_1 <= rigth_out_buffer_0_1 @[SPE.scala 32:18]
    io_right_out_0_2 <= rigth_out_buffer_0_2 @[SPE.scala 32:18]
    io_right_out_0_3 <= rigth_out_buffer_0_3 @[SPE.scala 32:18]
    io_right_out_1_0 <= rigth_out_buffer_1_0 @[SPE.scala 32:18]
    io_right_out_1_1 <= rigth_out_buffer_1_1 @[SPE.scala 32:18]
    io_right_out_1_2 <= rigth_out_buffer_1_2 @[SPE.scala 32:18]
    io_right_out_1_3 <= rigth_out_buffer_1_3 @[SPE.scala 32:18]
    io_weight_out_0_0 <= SPUs_0.io_weight_out_0 @[SPE.scala 26:26]
    io_weight_out_0_1 <= SPUs_0.io_weight_out_1 @[SPE.scala 26:26]
    io_weight_out_1_0 <= SPUs_1.io_weight_out_0 @[SPE.scala 26:26]
    io_weight_out_1_1 <= SPUs_1.io_weight_out_1 @[SPE.scala 26:26]
    io_index_out_0_0 <= SPUs_0.io_index_out_0 @[SPE.scala 27:25]
    io_index_out_0_1 <= SPUs_0.io_index_out_1 @[SPE.scala 27:25]
    io_index_out_1_0 <= SPUs_1.io_index_out_0 @[SPE.scala 27:25]
    io_index_out_1_1 <= SPUs_1.io_index_out_1 @[SPE.scala 27:25]
    io_down_out_0_0 <= SPUs_0.io_down_out_0 @[SPE.scala 28:24]
    io_down_out_0_1 <= SPUs_0.io_down_out_1 @[SPE.scala 28:24]
    io_down_out_1_0 <= SPUs_1.io_down_out_0 @[SPE.scala 28:24]
    io_down_out_1_1 <= SPUs_1.io_down_out_1 @[SPE.scala 28:24]
    SPUs_0.clock <= clock
    SPUs_0.reset <= reset
    SPUs_0.io_left_in_0_0 <= io_left_in_0_0 @[SPE.scala 21:28]
    SPUs_0.io_left_in_0_1 <= io_left_in_0_1 @[SPE.scala 21:28]
    SPUs_0.io_left_in_0_2 <= io_left_in_0_2 @[SPE.scala 21:28]
    SPUs_0.io_left_in_0_3 <= io_left_in_0_3 @[SPE.scala 21:28]
    SPUs_0.io_left_in_1_0 <= io_left_in_1_0 @[SPE.scala 21:28]
    SPUs_0.io_left_in_1_1 <= io_left_in_1_1 @[SPE.scala 21:28]
    SPUs_0.io_left_in_1_2 <= io_left_in_1_2 @[SPE.scala 21:28]
    SPUs_0.io_left_in_1_3 <= io_left_in_1_3 @[SPE.scala 21:28]
    SPUs_0.io_up_in_0 <= io_up_in_0_0 @[SPE.scala 22:26]
    SPUs_0.io_up_in_1 <= io_up_in_0_1 @[SPE.scala 22:26]
    SPUs_0.io_weight_in_0 <= io_weight_in_0_0 @[SPE.scala 23:30]
    SPUs_0.io_weight_in_1 <= io_weight_in_0_1 @[SPE.scala 23:30]
    SPUs_0.io_index_in_0 <= io_index_in_0_0 @[SPE.scala 24:29]
    SPUs_0.io_index_in_1 <= io_index_in_0_1 @[SPE.scala 24:29]
    SPUs_0.io_weight_load_en <= io_weight_load_en @[SPE.scala 25:35]
    SPUs_1.clock <= clock
    SPUs_1.reset <= reset
    SPUs_1.io_left_in_0_0 <= io_left_in_0_0 @[SPE.scala 21:28]
    SPUs_1.io_left_in_0_1 <= io_left_in_0_1 @[SPE.scala 21:28]
    SPUs_1.io_left_in_0_2 <= io_left_in_0_2 @[SPE.scala 21:28]
    SPUs_1.io_left_in_0_3 <= io_left_in_0_3 @[SPE.scala 21:28]
    SPUs_1.io_left_in_1_0 <= io_left_in_1_0 @[SPE.scala 21:28]
    SPUs_1.io_left_in_1_1 <= io_left_in_1_1 @[SPE.scala 21:28]
    SPUs_1.io_left_in_1_2 <= io_left_in_1_2 @[SPE.scala 21:28]
    SPUs_1.io_left_in_1_3 <= io_left_in_1_3 @[SPE.scala 21:28]
    SPUs_1.io_up_in_0 <= io_up_in_1_0 @[SPE.scala 22:26]
    SPUs_1.io_up_in_1 <= io_up_in_1_1 @[SPE.scala 22:26]
    SPUs_1.io_weight_in_0 <= io_weight_in_1_0 @[SPE.scala 23:30]
    SPUs_1.io_weight_in_1 <= io_weight_in_1_1 @[SPE.scala 23:30]
    SPUs_1.io_index_in_0 <= io_index_in_1_0 @[SPE.scala 24:29]
    SPUs_1.io_index_in_1 <= io_index_in_1_1 @[SPE.scala 24:29]
    SPUs_1.io_weight_load_en <= io_weight_load_en @[SPE.scala 25:35]
    rigth_out_buffer_0_0 <= io_left_in_0_0 @[SPE.scala 31:22]
    rigth_out_buffer_0_1 <= io_left_in_0_1 @[SPE.scala 31:22]
    rigth_out_buffer_0_2 <= io_left_in_0_2 @[SPE.scala 31:22]
    rigth_out_buffer_0_3 <= io_left_in_0_3 @[SPE.scala 31:22]
    rigth_out_buffer_1_0 <= io_left_in_1_0 @[SPE.scala 31:22]
    rigth_out_buffer_1_1 <= io_left_in_1_1 @[SPE.scala 31:22]
    rigth_out_buffer_1_2 <= io_left_in_1_2 @[SPE.scala 31:22]
    rigth_out_buffer_1_3 <= io_left_in_1_3 @[SPE.scala 31:22]

  module vegeta_sa :
    input clock : Clock
    input reset : UInt<1>
    input io_left_in_0_0_0 : SInt<32>
    input io_left_in_0_0_1 : SInt<32>
    input io_left_in_0_0_2 : SInt<32>
    input io_left_in_0_0_3 : SInt<32>
    input io_left_in_0_1_0 : SInt<32>
    input io_left_in_0_1_1 : SInt<32>
    input io_left_in_0_1_2 : SInt<32>
    input io_left_in_0_1_3 : SInt<32>
    input io_left_in_1_0_0 : SInt<32>
    input io_left_in_1_0_1 : SInt<32>
    input io_left_in_1_0_2 : SInt<32>
    input io_left_in_1_0_3 : SInt<32>
    input io_left_in_1_1_0 : SInt<32>
    input io_left_in_1_1_1 : SInt<32>
    input io_left_in_1_1_2 : SInt<32>
    input io_left_in_1_1_3 : SInt<32>
    input io_left_in_2_0_0 : SInt<32>
    input io_left_in_2_0_1 : SInt<32>
    input io_left_in_2_0_2 : SInt<32>
    input io_left_in_2_0_3 : SInt<32>
    input io_left_in_2_1_0 : SInt<32>
    input io_left_in_2_1_1 : SInt<32>
    input io_left_in_2_1_2 : SInt<32>
    input io_left_in_2_1_3 : SInt<32>
    input io_left_in_3_0_0 : SInt<32>
    input io_left_in_3_0_1 : SInt<32>
    input io_left_in_3_0_2 : SInt<32>
    input io_left_in_3_0_3 : SInt<32>
    input io_left_in_3_1_0 : SInt<32>
    input io_left_in_3_1_1 : SInt<32>
    input io_left_in_3_1_2 : SInt<32>
    input io_left_in_3_1_3 : SInt<32>
    input io_left_in_4_0_0 : SInt<32>
    input io_left_in_4_0_1 : SInt<32>
    input io_left_in_4_0_2 : SInt<32>
    input io_left_in_4_0_3 : SInt<32>
    input io_left_in_4_1_0 : SInt<32>
    input io_left_in_4_1_1 : SInt<32>
    input io_left_in_4_1_2 : SInt<32>
    input io_left_in_4_1_3 : SInt<32>
    input io_left_in_5_0_0 : SInt<32>
    input io_left_in_5_0_1 : SInt<32>
    input io_left_in_5_0_2 : SInt<32>
    input io_left_in_5_0_3 : SInt<32>
    input io_left_in_5_1_0 : SInt<32>
    input io_left_in_5_1_1 : SInt<32>
    input io_left_in_5_1_2 : SInt<32>
    input io_left_in_5_1_3 : SInt<32>
    input io_left_in_6_0_0 : SInt<32>
    input io_left_in_6_0_1 : SInt<32>
    input io_left_in_6_0_2 : SInt<32>
    input io_left_in_6_0_3 : SInt<32>
    input io_left_in_6_1_0 : SInt<32>
    input io_left_in_6_1_1 : SInt<32>
    input io_left_in_6_1_2 : SInt<32>
    input io_left_in_6_1_3 : SInt<32>
    input io_left_in_7_0_0 : SInt<32>
    input io_left_in_7_0_1 : SInt<32>
    input io_left_in_7_0_2 : SInt<32>
    input io_left_in_7_0_3 : SInt<32>
    input io_left_in_7_1_0 : SInt<32>
    input io_left_in_7_1_1 : SInt<32>
    input io_left_in_7_1_2 : SInt<32>
    input io_left_in_7_1_3 : SInt<32>
    input io_left_in_8_0_0 : SInt<32>
    input io_left_in_8_0_1 : SInt<32>
    input io_left_in_8_0_2 : SInt<32>
    input io_left_in_8_0_3 : SInt<32>
    input io_left_in_8_1_0 : SInt<32>
    input io_left_in_8_1_1 : SInt<32>
    input io_left_in_8_1_2 : SInt<32>
    input io_left_in_8_1_3 : SInt<32>
    input io_left_in_9_0_0 : SInt<32>
    input io_left_in_9_0_1 : SInt<32>
    input io_left_in_9_0_2 : SInt<32>
    input io_left_in_9_0_3 : SInt<32>
    input io_left_in_9_1_0 : SInt<32>
    input io_left_in_9_1_1 : SInt<32>
    input io_left_in_9_1_2 : SInt<32>
    input io_left_in_9_1_3 : SInt<32>
    input io_left_in_10_0_0 : SInt<32>
    input io_left_in_10_0_1 : SInt<32>
    input io_left_in_10_0_2 : SInt<32>
    input io_left_in_10_0_3 : SInt<32>
    input io_left_in_10_1_0 : SInt<32>
    input io_left_in_10_1_1 : SInt<32>
    input io_left_in_10_1_2 : SInt<32>
    input io_left_in_10_1_3 : SInt<32>
    input io_left_in_11_0_0 : SInt<32>
    input io_left_in_11_0_1 : SInt<32>
    input io_left_in_11_0_2 : SInt<32>
    input io_left_in_11_0_3 : SInt<32>
    input io_left_in_11_1_0 : SInt<32>
    input io_left_in_11_1_1 : SInt<32>
    input io_left_in_11_1_2 : SInt<32>
    input io_left_in_11_1_3 : SInt<32>
    input io_left_in_12_0_0 : SInt<32>
    input io_left_in_12_0_1 : SInt<32>
    input io_left_in_12_0_2 : SInt<32>
    input io_left_in_12_0_3 : SInt<32>
    input io_left_in_12_1_0 : SInt<32>
    input io_left_in_12_1_1 : SInt<32>
    input io_left_in_12_1_2 : SInt<32>
    input io_left_in_12_1_3 : SInt<32>
    input io_left_in_13_0_0 : SInt<32>
    input io_left_in_13_0_1 : SInt<32>
    input io_left_in_13_0_2 : SInt<32>
    input io_left_in_13_0_3 : SInt<32>
    input io_left_in_13_1_0 : SInt<32>
    input io_left_in_13_1_1 : SInt<32>
    input io_left_in_13_1_2 : SInt<32>
    input io_left_in_13_1_3 : SInt<32>
    input io_left_in_14_0_0 : SInt<32>
    input io_left_in_14_0_1 : SInt<32>
    input io_left_in_14_0_2 : SInt<32>
    input io_left_in_14_0_3 : SInt<32>
    input io_left_in_14_1_0 : SInt<32>
    input io_left_in_14_1_1 : SInt<32>
    input io_left_in_14_1_2 : SInt<32>
    input io_left_in_14_1_3 : SInt<32>
    input io_left_in_15_0_0 : SInt<32>
    input io_left_in_15_0_1 : SInt<32>
    input io_left_in_15_0_2 : SInt<32>
    input io_left_in_15_0_3 : SInt<32>
    input io_left_in_15_1_0 : SInt<32>
    input io_left_in_15_1_1 : SInt<32>
    input io_left_in_15_1_2 : SInt<32>
    input io_left_in_15_1_3 : SInt<32>
    input io_weight_in_0_0_0 : SInt<32>
    input io_weight_in_0_0_1 : SInt<32>
    input io_weight_in_0_1_0 : SInt<32>
    input io_weight_in_0_1_1 : SInt<32>
    input io_weight_in_1_0_0 : SInt<32>
    input io_weight_in_1_0_1 : SInt<32>
    input io_weight_in_1_1_0 : SInt<32>
    input io_weight_in_1_1_1 : SInt<32>
    input io_index_in_0_0_0 : UInt<2>
    input io_index_in_0_0_1 : UInt<2>
    input io_index_in_0_1_0 : UInt<2>
    input io_index_in_0_1_1 : UInt<2>
    input io_index_in_1_0_0 : UInt<2>
    input io_index_in_1_0_1 : UInt<2>
    input io_index_in_1_1_0 : UInt<2>
    input io_index_in_1_1_1 : UInt<2>
    input io_weight_load_en : UInt<1>
    output io_output_0_0_0 : SInt<32>
    output io_output_0_0_1 : SInt<32>
    output io_output_0_1_0 : SInt<32>
    output io_output_0_1_1 : SInt<32>
    output io_output_1_0_0 : SInt<32>
    output io_output_1_0_1 : SInt<32>
    output io_output_1_1_0 : SInt<32>
    output io_output_1_1_1 : SInt<32>
    output io_SPE_output_0_0_0_0 : SInt<32>
    output io_SPE_output_0_0_0_1 : SInt<32>
    output io_SPE_output_0_0_1_0 : SInt<32>
    output io_SPE_output_0_0_1_1 : SInt<32>
    output io_SPE_output_0_1_0_0 : SInt<32>
    output io_SPE_output_0_1_0_1 : SInt<32>
    output io_SPE_output_0_1_1_0 : SInt<32>
    output io_SPE_output_0_1_1_1 : SInt<32>
    output io_SPE_output_1_0_0_0 : SInt<32>
    output io_SPE_output_1_0_0_1 : SInt<32>
    output io_SPE_output_1_0_1_0 : SInt<32>
    output io_SPE_output_1_0_1_1 : SInt<32>
    output io_SPE_output_1_1_0_0 : SInt<32>
    output io_SPE_output_1_1_0_1 : SInt<32>
    output io_SPE_output_1_1_1_0 : SInt<32>
    output io_SPE_output_1_1_1_1 : SInt<32>
    output io_SPE_output_2_0_0_0 : SInt<32>
    output io_SPE_output_2_0_0_1 : SInt<32>
    output io_SPE_output_2_0_1_0 : SInt<32>
    output io_SPE_output_2_0_1_1 : SInt<32>
    output io_SPE_output_2_1_0_0 : SInt<32>
    output io_SPE_output_2_1_0_1 : SInt<32>
    output io_SPE_output_2_1_1_0 : SInt<32>
    output io_SPE_output_2_1_1_1 : SInt<32>
    output io_SPE_output_3_0_0_0 : SInt<32>
    output io_SPE_output_3_0_0_1 : SInt<32>
    output io_SPE_output_3_0_1_0 : SInt<32>
    output io_SPE_output_3_0_1_1 : SInt<32>
    output io_SPE_output_3_1_0_0 : SInt<32>
    output io_SPE_output_3_1_0_1 : SInt<32>
    output io_SPE_output_3_1_1_0 : SInt<32>
    output io_SPE_output_3_1_1_1 : SInt<32>
    output io_SPE_output_4_0_0_0 : SInt<32>
    output io_SPE_output_4_0_0_1 : SInt<32>
    output io_SPE_output_4_0_1_0 : SInt<32>
    output io_SPE_output_4_0_1_1 : SInt<32>
    output io_SPE_output_4_1_0_0 : SInt<32>
    output io_SPE_output_4_1_0_1 : SInt<32>
    output io_SPE_output_4_1_1_0 : SInt<32>
    output io_SPE_output_4_1_1_1 : SInt<32>
    output io_SPE_output_5_0_0_0 : SInt<32>
    output io_SPE_output_5_0_0_1 : SInt<32>
    output io_SPE_output_5_0_1_0 : SInt<32>
    output io_SPE_output_5_0_1_1 : SInt<32>
    output io_SPE_output_5_1_0_0 : SInt<32>
    output io_SPE_output_5_1_0_1 : SInt<32>
    output io_SPE_output_5_1_1_0 : SInt<32>
    output io_SPE_output_5_1_1_1 : SInt<32>
    output io_SPE_output_6_0_0_0 : SInt<32>
    output io_SPE_output_6_0_0_1 : SInt<32>
    output io_SPE_output_6_0_1_0 : SInt<32>
    output io_SPE_output_6_0_1_1 : SInt<32>
    output io_SPE_output_6_1_0_0 : SInt<32>
    output io_SPE_output_6_1_0_1 : SInt<32>
    output io_SPE_output_6_1_1_0 : SInt<32>
    output io_SPE_output_6_1_1_1 : SInt<32>
    output io_SPE_output_7_0_0_0 : SInt<32>
    output io_SPE_output_7_0_0_1 : SInt<32>
    output io_SPE_output_7_0_1_0 : SInt<32>
    output io_SPE_output_7_0_1_1 : SInt<32>
    output io_SPE_output_7_1_0_0 : SInt<32>
    output io_SPE_output_7_1_0_1 : SInt<32>
    output io_SPE_output_7_1_1_0 : SInt<32>
    output io_SPE_output_7_1_1_1 : SInt<32>
    output io_SPE_output_8_0_0_0 : SInt<32>
    output io_SPE_output_8_0_0_1 : SInt<32>
    output io_SPE_output_8_0_1_0 : SInt<32>
    output io_SPE_output_8_0_1_1 : SInt<32>
    output io_SPE_output_8_1_0_0 : SInt<32>
    output io_SPE_output_8_1_0_1 : SInt<32>
    output io_SPE_output_8_1_1_0 : SInt<32>
    output io_SPE_output_8_1_1_1 : SInt<32>
    output io_SPE_output_9_0_0_0 : SInt<32>
    output io_SPE_output_9_0_0_1 : SInt<32>
    output io_SPE_output_9_0_1_0 : SInt<32>
    output io_SPE_output_9_0_1_1 : SInt<32>
    output io_SPE_output_9_1_0_0 : SInt<32>
    output io_SPE_output_9_1_0_1 : SInt<32>
    output io_SPE_output_9_1_1_0 : SInt<32>
    output io_SPE_output_9_1_1_1 : SInt<32>
    output io_SPE_output_10_0_0_0 : SInt<32>
    output io_SPE_output_10_0_0_1 : SInt<32>
    output io_SPE_output_10_0_1_0 : SInt<32>
    output io_SPE_output_10_0_1_1 : SInt<32>
    output io_SPE_output_10_1_0_0 : SInt<32>
    output io_SPE_output_10_1_0_1 : SInt<32>
    output io_SPE_output_10_1_1_0 : SInt<32>
    output io_SPE_output_10_1_1_1 : SInt<32>
    output io_SPE_output_11_0_0_0 : SInt<32>
    output io_SPE_output_11_0_0_1 : SInt<32>
    output io_SPE_output_11_0_1_0 : SInt<32>
    output io_SPE_output_11_0_1_1 : SInt<32>
    output io_SPE_output_11_1_0_0 : SInt<32>
    output io_SPE_output_11_1_0_1 : SInt<32>
    output io_SPE_output_11_1_1_0 : SInt<32>
    output io_SPE_output_11_1_1_1 : SInt<32>
    output io_SPE_output_12_0_0_0 : SInt<32>
    output io_SPE_output_12_0_0_1 : SInt<32>
    output io_SPE_output_12_0_1_0 : SInt<32>
    output io_SPE_output_12_0_1_1 : SInt<32>
    output io_SPE_output_12_1_0_0 : SInt<32>
    output io_SPE_output_12_1_0_1 : SInt<32>
    output io_SPE_output_12_1_1_0 : SInt<32>
    output io_SPE_output_12_1_1_1 : SInt<32>
    output io_SPE_output_13_0_0_0 : SInt<32>
    output io_SPE_output_13_0_0_1 : SInt<32>
    output io_SPE_output_13_0_1_0 : SInt<32>
    output io_SPE_output_13_0_1_1 : SInt<32>
    output io_SPE_output_13_1_0_0 : SInt<32>
    output io_SPE_output_13_1_0_1 : SInt<32>
    output io_SPE_output_13_1_1_0 : SInt<32>
    output io_SPE_output_13_1_1_1 : SInt<32>
    output io_SPE_output_14_0_0_0 : SInt<32>
    output io_SPE_output_14_0_0_1 : SInt<32>
    output io_SPE_output_14_0_1_0 : SInt<32>
    output io_SPE_output_14_0_1_1 : SInt<32>
    output io_SPE_output_14_1_0_0 : SInt<32>
    output io_SPE_output_14_1_0_1 : SInt<32>
    output io_SPE_output_14_1_1_0 : SInt<32>
    output io_SPE_output_14_1_1_1 : SInt<32>
    output io_SPE_output_15_0_0_0 : SInt<32>
    output io_SPE_output_15_0_0_1 : SInt<32>
    output io_SPE_output_15_0_1_0 : SInt<32>
    output io_SPE_output_15_0_1_1 : SInt<32>
    output io_SPE_output_15_1_0_0 : SInt<32>
    output io_SPE_output_15_1_0_1 : SInt<32>
    output io_SPE_output_15_1_1_0 : SInt<32>
    output io_SPE_output_15_1_1_1 : SInt<32>

    inst SPEs_0_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_0_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_1_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_1_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_2_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_2_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_3_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_3_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_4_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_4_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_5_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_5_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_6_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_6_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_7_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_7_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_8_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_8_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_9_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_9_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_10_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_10_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_11_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_11_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_12_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_12_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_13_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_13_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_14_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_14_1 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_15_0 of SPE @[vegeta_sa.scala 15:56]
    inst SPEs_15_1 of SPE @[vegeta_sa.scala 15:56]
    node _input_zero_WIRE__0 = asSInt(UInt<32>("h0")) @[vegeta_sa.scala 16:{64,64}]
    node _input_zero_WIRE__1 = asSInt(UInt<32>("h0")) @[vegeta_sa.scala 16:{64,64}]
    node _input_zero_WIRE_1_0 = asSInt(UInt<32>("h0")) @[vegeta_sa.scala 16:{64,64}]
    node _input_zero_WIRE_1_1 = asSInt(UInt<32>("h0")) @[vegeta_sa.scala 16:{64,64}]
    node input_zero_0_0 = _input_zero_WIRE__0 @[vegeta_sa.scala 16:{29,29}]
    node input_zero_0_1 = _input_zero_WIRE__1 @[vegeta_sa.scala 16:{29,29}]
    node input_zero_1_0 = _input_zero_WIRE_1_0 @[vegeta_sa.scala 16:{29,29}]
    node input_zero_1_1 = _input_zero_WIRE_1_1 @[vegeta_sa.scala 16:{29,29}]
    io_output_0_0_0 <= SPEs_15_0.io_down_out_0_0 @[vegeta_sa.scala 43:36]
    io_output_0_0_1 <= SPEs_15_0.io_down_out_0_1 @[vegeta_sa.scala 43:36]
    io_output_0_1_0 <= SPEs_15_0.io_down_out_1_0 @[vegeta_sa.scala 43:36]
    io_output_0_1_1 <= SPEs_15_0.io_down_out_1_1 @[vegeta_sa.scala 43:36]
    io_output_1_0_0 <= SPEs_15_1.io_down_out_0_0 @[vegeta_sa.scala 43:36]
    io_output_1_0_1 <= SPEs_15_1.io_down_out_0_1 @[vegeta_sa.scala 43:36]
    io_output_1_1_0 <= SPEs_15_1.io_down_out_1_0 @[vegeta_sa.scala 43:36]
    io_output_1_1_1 <= SPEs_15_1.io_down_out_1_1 @[vegeta_sa.scala 43:36]
    io_SPE_output_0_0_0_0 <= SPEs_0_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_0_0_1 <= SPEs_0_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_0_1_0 <= SPEs_0_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_0_1_1 <= SPEs_0_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_1_0_0 <= SPEs_0_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_1_0_1 <= SPEs_0_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_1_1_0 <= SPEs_0_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_0_1_1_1 <= SPEs_0_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_0_0_0 <= SPEs_1_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_0_0_1 <= SPEs_1_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_0_1_0 <= SPEs_1_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_0_1_1 <= SPEs_1_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_1_0_0 <= SPEs_1_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_1_0_1 <= SPEs_1_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_1_1_0 <= SPEs_1_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_1_1_1_1 <= SPEs_1_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_0_0_0 <= SPEs_2_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_0_0_1 <= SPEs_2_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_0_1_0 <= SPEs_2_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_0_1_1 <= SPEs_2_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_1_0_0 <= SPEs_2_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_1_0_1 <= SPEs_2_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_1_1_0 <= SPEs_2_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_2_1_1_1 <= SPEs_2_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_0_0_0 <= SPEs_3_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_0_0_1 <= SPEs_3_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_0_1_0 <= SPEs_3_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_0_1_1 <= SPEs_3_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_1_0_0 <= SPEs_3_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_1_0_1 <= SPEs_3_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_1_1_0 <= SPEs_3_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_3_1_1_1 <= SPEs_3_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_0_0_0 <= SPEs_4_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_0_0_1 <= SPEs_4_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_0_1_0 <= SPEs_4_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_0_1_1 <= SPEs_4_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_1_0_0 <= SPEs_4_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_1_0_1 <= SPEs_4_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_1_1_0 <= SPEs_4_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_4_1_1_1 <= SPEs_4_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_0_0_0 <= SPEs_5_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_0_0_1 <= SPEs_5_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_0_1_0 <= SPEs_5_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_0_1_1 <= SPEs_5_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_1_0_0 <= SPEs_5_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_1_0_1 <= SPEs_5_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_1_1_0 <= SPEs_5_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_5_1_1_1 <= SPEs_5_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_0_0_0 <= SPEs_6_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_0_0_1 <= SPEs_6_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_0_1_0 <= SPEs_6_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_0_1_1 <= SPEs_6_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_1_0_0 <= SPEs_6_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_1_0_1 <= SPEs_6_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_1_1_0 <= SPEs_6_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_6_1_1_1 <= SPEs_6_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_0_0_0 <= SPEs_7_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_0_0_1 <= SPEs_7_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_0_1_0 <= SPEs_7_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_0_1_1 <= SPEs_7_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_1_0_0 <= SPEs_7_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_1_0_1 <= SPEs_7_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_1_1_0 <= SPEs_7_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_7_1_1_1 <= SPEs_7_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_0_0_0 <= SPEs_8_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_0_0_1 <= SPEs_8_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_0_1_0 <= SPEs_8_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_0_1_1 <= SPEs_8_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_1_0_0 <= SPEs_8_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_1_0_1 <= SPEs_8_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_1_1_0 <= SPEs_8_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_8_1_1_1 <= SPEs_8_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_0_0_0 <= SPEs_9_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_0_0_1 <= SPEs_9_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_0_1_0 <= SPEs_9_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_0_1_1 <= SPEs_9_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_1_0_0 <= SPEs_9_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_1_0_1 <= SPEs_9_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_1_1_0 <= SPEs_9_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_9_1_1_1 <= SPEs_9_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_0_0_0 <= SPEs_10_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_0_0_1 <= SPEs_10_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_0_1_0 <= SPEs_10_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_0_1_1 <= SPEs_10_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_1_0_0 <= SPEs_10_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_1_0_1 <= SPEs_10_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_1_1_0 <= SPEs_10_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_10_1_1_1 <= SPEs_10_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_0_0_0 <= SPEs_11_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_0_0_1 <= SPEs_11_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_0_1_0 <= SPEs_11_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_0_1_1 <= SPEs_11_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_1_0_0 <= SPEs_11_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_1_0_1 <= SPEs_11_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_1_1_0 <= SPEs_11_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_11_1_1_1 <= SPEs_11_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_0_0_0 <= SPEs_12_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_0_0_1 <= SPEs_12_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_0_1_0 <= SPEs_12_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_0_1_1 <= SPEs_12_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_1_0_0 <= SPEs_12_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_1_0_1 <= SPEs_12_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_1_1_0 <= SPEs_12_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_12_1_1_1 <= SPEs_12_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_0_0_0 <= SPEs_13_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_0_0_1 <= SPEs_13_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_0_1_0 <= SPEs_13_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_0_1_1 <= SPEs_13_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_1_0_0 <= SPEs_13_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_1_0_1 <= SPEs_13_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_1_1_0 <= SPEs_13_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_13_1_1_1 <= SPEs_13_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_0_0_0 <= SPEs_14_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_0_0_1 <= SPEs_14_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_0_1_0 <= SPEs_14_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_0_1_1 <= SPEs_14_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_1_0_0 <= SPEs_14_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_1_0_1 <= SPEs_14_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_1_1_0 <= SPEs_14_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_14_1_1_1 <= SPEs_14_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_0_0_0 <= SPEs_15_0.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_0_0_1 <= SPEs_15_0.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_0_1_0 <= SPEs_15_0.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_0_1_1 <= SPEs_15_0.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_1_0_0 <= SPEs_15_1.io_down_out_0_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_1_0_1 <= SPEs_15_1.io_down_out_0_1 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_1_1_0 <= SPEs_15_1.io_down_out_1_0 @[vegeta_sa.scala 48:33]
    io_SPE_output_15_1_1_1 <= SPEs_15_1.io_down_out_1_1 @[vegeta_sa.scala 48:33]
    SPEs_0_0.clock <= clock
    SPEs_0_0.reset <= reset
    SPEs_0_0.io_left_in_0_0 <= io_left_in_0_0_0 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_0_1 <= io_left_in_0_0_1 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_0_2 <= io_left_in_0_0_2 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_0_3 <= io_left_in_0_0_3 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_1_0 <= io_left_in_0_1_0 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_1_1 <= io_left_in_0_1_1 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_1_2 <= io_left_in_0_1_2 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_left_in_1_3 <= io_left_in_0_1_3 @[vegeta_sa.scala 23:39]
    SPEs_0_0.io_up_in_0_0 <= input_zero_0_0 @[vegeta_sa.scala 31:37]
    SPEs_0_0.io_up_in_0_1 <= input_zero_0_1 @[vegeta_sa.scala 31:37]
    SPEs_0_0.io_up_in_1_0 <= input_zero_1_0 @[vegeta_sa.scala 31:37]
    SPEs_0_0.io_up_in_1_1 <= input_zero_1_1 @[vegeta_sa.scala 31:37]
    SPEs_0_0.io_weight_in_0_0 <= io_weight_in_0_0_0 @[vegeta_sa.scala 29:41]
    SPEs_0_0.io_weight_in_0_1 <= io_weight_in_0_0_1 @[vegeta_sa.scala 29:41]
    SPEs_0_0.io_weight_in_1_0 <= io_weight_in_0_1_0 @[vegeta_sa.scala 29:41]
    SPEs_0_0.io_weight_in_1_1 <= io_weight_in_0_1_1 @[vegeta_sa.scala 29:41]
    SPEs_0_0.io_index_in_0_0 <= io_index_in_0_0_0 @[vegeta_sa.scala 30:40]
    SPEs_0_0.io_index_in_0_1 <= io_index_in_0_0_1 @[vegeta_sa.scala 30:40]
    SPEs_0_0.io_index_in_1_0 <= io_index_in_0_1_0 @[vegeta_sa.scala 30:40]
    SPEs_0_0.io_index_in_1_1 <= io_index_in_0_1_1 @[vegeta_sa.scala 30:40]
    SPEs_0_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_0_1.clock <= clock
    SPEs_0_1.reset <= reset
    SPEs_0_1.io_left_in_0_0 <= SPEs_0_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_0_1 <= SPEs_0_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_0_2 <= SPEs_0_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_0_3 <= SPEs_0_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_1_0 <= SPEs_0_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_1_1 <= SPEs_0_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_1_2 <= SPEs_0_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_left_in_1_3 <= SPEs_0_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_0_1.io_up_in_0_0 <= input_zero_0_0 @[vegeta_sa.scala 31:37]
    SPEs_0_1.io_up_in_0_1 <= input_zero_0_1 @[vegeta_sa.scala 31:37]
    SPEs_0_1.io_up_in_1_0 <= input_zero_1_0 @[vegeta_sa.scala 31:37]
    SPEs_0_1.io_up_in_1_1 <= input_zero_1_1 @[vegeta_sa.scala 31:37]
    SPEs_0_1.io_weight_in_0_0 <= io_weight_in_1_0_0 @[vegeta_sa.scala 29:41]
    SPEs_0_1.io_weight_in_0_1 <= io_weight_in_1_0_1 @[vegeta_sa.scala 29:41]
    SPEs_0_1.io_weight_in_1_0 <= io_weight_in_1_1_0 @[vegeta_sa.scala 29:41]
    SPEs_0_1.io_weight_in_1_1 <= io_weight_in_1_1_1 @[vegeta_sa.scala 29:41]
    SPEs_0_1.io_index_in_0_0 <= io_index_in_1_0_0 @[vegeta_sa.scala 30:40]
    SPEs_0_1.io_index_in_0_1 <= io_index_in_1_0_1 @[vegeta_sa.scala 30:40]
    SPEs_0_1.io_index_in_1_0 <= io_index_in_1_1_0 @[vegeta_sa.scala 30:40]
    SPEs_0_1.io_index_in_1_1 <= io_index_in_1_1_1 @[vegeta_sa.scala 30:40]
    SPEs_0_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_1_0.clock <= clock
    SPEs_1_0.reset <= reset
    SPEs_1_0.io_left_in_0_0 <= io_left_in_1_0_0 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_0_1 <= io_left_in_1_0_1 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_0_2 <= io_left_in_1_0_2 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_0_3 <= io_left_in_1_0_3 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_1_0 <= io_left_in_1_1_0 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_1_1 <= io_left_in_1_1_1 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_1_2 <= io_left_in_1_1_2 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_left_in_1_3 <= io_left_in_1_1_3 @[vegeta_sa.scala 23:39]
    SPEs_1_0.io_up_in_0_0 <= SPEs_0_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_1_0.io_up_in_0_1 <= SPEs_0_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_1_0.io_up_in_1_0 <= SPEs_0_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_1_0.io_up_in_1_1 <= SPEs_0_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_1_0.io_weight_in_0_0 <= SPEs_0_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_1_0.io_weight_in_0_1 <= SPEs_0_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_1_0.io_weight_in_1_0 <= SPEs_0_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_1_0.io_weight_in_1_1 <= SPEs_0_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_1_0.io_index_in_0_0 <= SPEs_0_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_1_0.io_index_in_0_1 <= SPEs_0_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_1_0.io_index_in_1_0 <= SPEs_0_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_1_0.io_index_in_1_1 <= SPEs_0_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_1_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_1_1.clock <= clock
    SPEs_1_1.reset <= reset
    SPEs_1_1.io_left_in_0_0 <= SPEs_1_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_0_1 <= SPEs_1_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_0_2 <= SPEs_1_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_0_3 <= SPEs_1_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_1_0 <= SPEs_1_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_1_1 <= SPEs_1_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_1_2 <= SPEs_1_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_left_in_1_3 <= SPEs_1_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_1_1.io_up_in_0_0 <= SPEs_0_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_1_1.io_up_in_0_1 <= SPEs_0_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_1_1.io_up_in_1_0 <= SPEs_0_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_1_1.io_up_in_1_1 <= SPEs_0_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_1_1.io_weight_in_0_0 <= SPEs_0_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_1_1.io_weight_in_0_1 <= SPEs_0_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_1_1.io_weight_in_1_0 <= SPEs_0_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_1_1.io_weight_in_1_1 <= SPEs_0_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_1_1.io_index_in_0_0 <= SPEs_0_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_1_1.io_index_in_0_1 <= SPEs_0_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_1_1.io_index_in_1_0 <= SPEs_0_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_1_1.io_index_in_1_1 <= SPEs_0_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_1_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_2_0.clock <= clock
    SPEs_2_0.reset <= reset
    SPEs_2_0.io_left_in_0_0 <= io_left_in_2_0_0 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_0_1 <= io_left_in_2_0_1 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_0_2 <= io_left_in_2_0_2 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_0_3 <= io_left_in_2_0_3 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_1_0 <= io_left_in_2_1_0 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_1_1 <= io_left_in_2_1_1 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_1_2 <= io_left_in_2_1_2 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_left_in_1_3 <= io_left_in_2_1_3 @[vegeta_sa.scala 23:39]
    SPEs_2_0.io_up_in_0_0 <= SPEs_1_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_2_0.io_up_in_0_1 <= SPEs_1_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_2_0.io_up_in_1_0 <= SPEs_1_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_2_0.io_up_in_1_1 <= SPEs_1_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_2_0.io_weight_in_0_0 <= SPEs_1_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_2_0.io_weight_in_0_1 <= SPEs_1_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_2_0.io_weight_in_1_0 <= SPEs_1_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_2_0.io_weight_in_1_1 <= SPEs_1_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_2_0.io_index_in_0_0 <= SPEs_1_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_2_0.io_index_in_0_1 <= SPEs_1_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_2_0.io_index_in_1_0 <= SPEs_1_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_2_0.io_index_in_1_1 <= SPEs_1_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_2_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_2_1.clock <= clock
    SPEs_2_1.reset <= reset
    SPEs_2_1.io_left_in_0_0 <= SPEs_2_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_0_1 <= SPEs_2_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_0_2 <= SPEs_2_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_0_3 <= SPEs_2_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_1_0 <= SPEs_2_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_1_1 <= SPEs_2_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_1_2 <= SPEs_2_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_left_in_1_3 <= SPEs_2_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_2_1.io_up_in_0_0 <= SPEs_1_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_2_1.io_up_in_0_1 <= SPEs_1_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_2_1.io_up_in_1_0 <= SPEs_1_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_2_1.io_up_in_1_1 <= SPEs_1_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_2_1.io_weight_in_0_0 <= SPEs_1_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_2_1.io_weight_in_0_1 <= SPEs_1_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_2_1.io_weight_in_1_0 <= SPEs_1_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_2_1.io_weight_in_1_1 <= SPEs_1_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_2_1.io_index_in_0_0 <= SPEs_1_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_2_1.io_index_in_0_1 <= SPEs_1_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_2_1.io_index_in_1_0 <= SPEs_1_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_2_1.io_index_in_1_1 <= SPEs_1_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_2_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_3_0.clock <= clock
    SPEs_3_0.reset <= reset
    SPEs_3_0.io_left_in_0_0 <= io_left_in_3_0_0 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_0_1 <= io_left_in_3_0_1 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_0_2 <= io_left_in_3_0_2 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_0_3 <= io_left_in_3_0_3 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_1_0 <= io_left_in_3_1_0 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_1_1 <= io_left_in_3_1_1 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_1_2 <= io_left_in_3_1_2 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_left_in_1_3 <= io_left_in_3_1_3 @[vegeta_sa.scala 23:39]
    SPEs_3_0.io_up_in_0_0 <= SPEs_2_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_3_0.io_up_in_0_1 <= SPEs_2_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_3_0.io_up_in_1_0 <= SPEs_2_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_3_0.io_up_in_1_1 <= SPEs_2_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_3_0.io_weight_in_0_0 <= SPEs_2_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_3_0.io_weight_in_0_1 <= SPEs_2_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_3_0.io_weight_in_1_0 <= SPEs_2_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_3_0.io_weight_in_1_1 <= SPEs_2_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_3_0.io_index_in_0_0 <= SPEs_2_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_3_0.io_index_in_0_1 <= SPEs_2_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_3_0.io_index_in_1_0 <= SPEs_2_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_3_0.io_index_in_1_1 <= SPEs_2_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_3_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_3_1.clock <= clock
    SPEs_3_1.reset <= reset
    SPEs_3_1.io_left_in_0_0 <= SPEs_3_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_0_1 <= SPEs_3_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_0_2 <= SPEs_3_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_0_3 <= SPEs_3_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_1_0 <= SPEs_3_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_1_1 <= SPEs_3_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_1_2 <= SPEs_3_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_left_in_1_3 <= SPEs_3_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_3_1.io_up_in_0_0 <= SPEs_2_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_3_1.io_up_in_0_1 <= SPEs_2_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_3_1.io_up_in_1_0 <= SPEs_2_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_3_1.io_up_in_1_1 <= SPEs_2_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_3_1.io_weight_in_0_0 <= SPEs_2_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_3_1.io_weight_in_0_1 <= SPEs_2_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_3_1.io_weight_in_1_0 <= SPEs_2_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_3_1.io_weight_in_1_1 <= SPEs_2_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_3_1.io_index_in_0_0 <= SPEs_2_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_3_1.io_index_in_0_1 <= SPEs_2_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_3_1.io_index_in_1_0 <= SPEs_2_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_3_1.io_index_in_1_1 <= SPEs_2_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_3_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_4_0.clock <= clock
    SPEs_4_0.reset <= reset
    SPEs_4_0.io_left_in_0_0 <= io_left_in_4_0_0 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_0_1 <= io_left_in_4_0_1 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_0_2 <= io_left_in_4_0_2 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_0_3 <= io_left_in_4_0_3 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_1_0 <= io_left_in_4_1_0 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_1_1 <= io_left_in_4_1_1 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_1_2 <= io_left_in_4_1_2 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_left_in_1_3 <= io_left_in_4_1_3 @[vegeta_sa.scala 23:39]
    SPEs_4_0.io_up_in_0_0 <= SPEs_3_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_4_0.io_up_in_0_1 <= SPEs_3_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_4_0.io_up_in_1_0 <= SPEs_3_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_4_0.io_up_in_1_1 <= SPEs_3_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_4_0.io_weight_in_0_0 <= SPEs_3_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_4_0.io_weight_in_0_1 <= SPEs_3_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_4_0.io_weight_in_1_0 <= SPEs_3_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_4_0.io_weight_in_1_1 <= SPEs_3_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_4_0.io_index_in_0_0 <= SPEs_3_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_4_0.io_index_in_0_1 <= SPEs_3_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_4_0.io_index_in_1_0 <= SPEs_3_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_4_0.io_index_in_1_1 <= SPEs_3_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_4_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_4_1.clock <= clock
    SPEs_4_1.reset <= reset
    SPEs_4_1.io_left_in_0_0 <= SPEs_4_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_0_1 <= SPEs_4_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_0_2 <= SPEs_4_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_0_3 <= SPEs_4_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_1_0 <= SPEs_4_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_1_1 <= SPEs_4_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_1_2 <= SPEs_4_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_left_in_1_3 <= SPEs_4_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_4_1.io_up_in_0_0 <= SPEs_3_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_4_1.io_up_in_0_1 <= SPEs_3_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_4_1.io_up_in_1_0 <= SPEs_3_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_4_1.io_up_in_1_1 <= SPEs_3_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_4_1.io_weight_in_0_0 <= SPEs_3_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_4_1.io_weight_in_0_1 <= SPEs_3_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_4_1.io_weight_in_1_0 <= SPEs_3_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_4_1.io_weight_in_1_1 <= SPEs_3_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_4_1.io_index_in_0_0 <= SPEs_3_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_4_1.io_index_in_0_1 <= SPEs_3_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_4_1.io_index_in_1_0 <= SPEs_3_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_4_1.io_index_in_1_1 <= SPEs_3_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_4_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_5_0.clock <= clock
    SPEs_5_0.reset <= reset
    SPEs_5_0.io_left_in_0_0 <= io_left_in_5_0_0 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_0_1 <= io_left_in_5_0_1 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_0_2 <= io_left_in_5_0_2 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_0_3 <= io_left_in_5_0_3 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_1_0 <= io_left_in_5_1_0 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_1_1 <= io_left_in_5_1_1 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_1_2 <= io_left_in_5_1_2 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_left_in_1_3 <= io_left_in_5_1_3 @[vegeta_sa.scala 23:39]
    SPEs_5_0.io_up_in_0_0 <= SPEs_4_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_5_0.io_up_in_0_1 <= SPEs_4_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_5_0.io_up_in_1_0 <= SPEs_4_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_5_0.io_up_in_1_1 <= SPEs_4_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_5_0.io_weight_in_0_0 <= SPEs_4_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_5_0.io_weight_in_0_1 <= SPEs_4_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_5_0.io_weight_in_1_0 <= SPEs_4_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_5_0.io_weight_in_1_1 <= SPEs_4_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_5_0.io_index_in_0_0 <= SPEs_4_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_5_0.io_index_in_0_1 <= SPEs_4_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_5_0.io_index_in_1_0 <= SPEs_4_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_5_0.io_index_in_1_1 <= SPEs_4_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_5_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_5_1.clock <= clock
    SPEs_5_1.reset <= reset
    SPEs_5_1.io_left_in_0_0 <= SPEs_5_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_0_1 <= SPEs_5_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_0_2 <= SPEs_5_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_0_3 <= SPEs_5_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_1_0 <= SPEs_5_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_1_1 <= SPEs_5_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_1_2 <= SPEs_5_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_left_in_1_3 <= SPEs_5_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_5_1.io_up_in_0_0 <= SPEs_4_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_5_1.io_up_in_0_1 <= SPEs_4_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_5_1.io_up_in_1_0 <= SPEs_4_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_5_1.io_up_in_1_1 <= SPEs_4_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_5_1.io_weight_in_0_0 <= SPEs_4_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_5_1.io_weight_in_0_1 <= SPEs_4_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_5_1.io_weight_in_1_0 <= SPEs_4_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_5_1.io_weight_in_1_1 <= SPEs_4_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_5_1.io_index_in_0_0 <= SPEs_4_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_5_1.io_index_in_0_1 <= SPEs_4_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_5_1.io_index_in_1_0 <= SPEs_4_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_5_1.io_index_in_1_1 <= SPEs_4_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_5_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_6_0.clock <= clock
    SPEs_6_0.reset <= reset
    SPEs_6_0.io_left_in_0_0 <= io_left_in_6_0_0 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_0_1 <= io_left_in_6_0_1 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_0_2 <= io_left_in_6_0_2 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_0_3 <= io_left_in_6_0_3 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_1_0 <= io_left_in_6_1_0 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_1_1 <= io_left_in_6_1_1 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_1_2 <= io_left_in_6_1_2 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_left_in_1_3 <= io_left_in_6_1_3 @[vegeta_sa.scala 23:39]
    SPEs_6_0.io_up_in_0_0 <= SPEs_5_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_6_0.io_up_in_0_1 <= SPEs_5_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_6_0.io_up_in_1_0 <= SPEs_5_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_6_0.io_up_in_1_1 <= SPEs_5_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_6_0.io_weight_in_0_0 <= SPEs_5_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_6_0.io_weight_in_0_1 <= SPEs_5_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_6_0.io_weight_in_1_0 <= SPEs_5_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_6_0.io_weight_in_1_1 <= SPEs_5_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_6_0.io_index_in_0_0 <= SPEs_5_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_6_0.io_index_in_0_1 <= SPEs_5_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_6_0.io_index_in_1_0 <= SPEs_5_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_6_0.io_index_in_1_1 <= SPEs_5_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_6_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_6_1.clock <= clock
    SPEs_6_1.reset <= reset
    SPEs_6_1.io_left_in_0_0 <= SPEs_6_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_0_1 <= SPEs_6_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_0_2 <= SPEs_6_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_0_3 <= SPEs_6_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_1_0 <= SPEs_6_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_1_1 <= SPEs_6_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_1_2 <= SPEs_6_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_left_in_1_3 <= SPEs_6_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_6_1.io_up_in_0_0 <= SPEs_5_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_6_1.io_up_in_0_1 <= SPEs_5_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_6_1.io_up_in_1_0 <= SPEs_5_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_6_1.io_up_in_1_1 <= SPEs_5_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_6_1.io_weight_in_0_0 <= SPEs_5_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_6_1.io_weight_in_0_1 <= SPEs_5_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_6_1.io_weight_in_1_0 <= SPEs_5_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_6_1.io_weight_in_1_1 <= SPEs_5_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_6_1.io_index_in_0_0 <= SPEs_5_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_6_1.io_index_in_0_1 <= SPEs_5_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_6_1.io_index_in_1_0 <= SPEs_5_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_6_1.io_index_in_1_1 <= SPEs_5_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_6_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_7_0.clock <= clock
    SPEs_7_0.reset <= reset
    SPEs_7_0.io_left_in_0_0 <= io_left_in_7_0_0 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_0_1 <= io_left_in_7_0_1 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_0_2 <= io_left_in_7_0_2 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_0_3 <= io_left_in_7_0_3 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_1_0 <= io_left_in_7_1_0 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_1_1 <= io_left_in_7_1_1 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_1_2 <= io_left_in_7_1_2 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_left_in_1_3 <= io_left_in_7_1_3 @[vegeta_sa.scala 23:39]
    SPEs_7_0.io_up_in_0_0 <= SPEs_6_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_7_0.io_up_in_0_1 <= SPEs_6_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_7_0.io_up_in_1_0 <= SPEs_6_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_7_0.io_up_in_1_1 <= SPEs_6_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_7_0.io_weight_in_0_0 <= SPEs_6_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_7_0.io_weight_in_0_1 <= SPEs_6_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_7_0.io_weight_in_1_0 <= SPEs_6_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_7_0.io_weight_in_1_1 <= SPEs_6_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_7_0.io_index_in_0_0 <= SPEs_6_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_7_0.io_index_in_0_1 <= SPEs_6_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_7_0.io_index_in_1_0 <= SPEs_6_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_7_0.io_index_in_1_1 <= SPEs_6_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_7_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_7_1.clock <= clock
    SPEs_7_1.reset <= reset
    SPEs_7_1.io_left_in_0_0 <= SPEs_7_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_0_1 <= SPEs_7_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_0_2 <= SPEs_7_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_0_3 <= SPEs_7_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_1_0 <= SPEs_7_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_1_1 <= SPEs_7_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_1_2 <= SPEs_7_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_left_in_1_3 <= SPEs_7_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_7_1.io_up_in_0_0 <= SPEs_6_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_7_1.io_up_in_0_1 <= SPEs_6_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_7_1.io_up_in_1_0 <= SPEs_6_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_7_1.io_up_in_1_1 <= SPEs_6_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_7_1.io_weight_in_0_0 <= SPEs_6_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_7_1.io_weight_in_0_1 <= SPEs_6_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_7_1.io_weight_in_1_0 <= SPEs_6_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_7_1.io_weight_in_1_1 <= SPEs_6_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_7_1.io_index_in_0_0 <= SPEs_6_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_7_1.io_index_in_0_1 <= SPEs_6_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_7_1.io_index_in_1_0 <= SPEs_6_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_7_1.io_index_in_1_1 <= SPEs_6_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_7_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_8_0.clock <= clock
    SPEs_8_0.reset <= reset
    SPEs_8_0.io_left_in_0_0 <= io_left_in_8_0_0 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_0_1 <= io_left_in_8_0_1 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_0_2 <= io_left_in_8_0_2 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_0_3 <= io_left_in_8_0_3 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_1_0 <= io_left_in_8_1_0 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_1_1 <= io_left_in_8_1_1 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_1_2 <= io_left_in_8_1_2 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_left_in_1_3 <= io_left_in_8_1_3 @[vegeta_sa.scala 23:39]
    SPEs_8_0.io_up_in_0_0 <= SPEs_7_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_8_0.io_up_in_0_1 <= SPEs_7_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_8_0.io_up_in_1_0 <= SPEs_7_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_8_0.io_up_in_1_1 <= SPEs_7_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_8_0.io_weight_in_0_0 <= SPEs_7_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_8_0.io_weight_in_0_1 <= SPEs_7_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_8_0.io_weight_in_1_0 <= SPEs_7_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_8_0.io_weight_in_1_1 <= SPEs_7_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_8_0.io_index_in_0_0 <= SPEs_7_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_8_0.io_index_in_0_1 <= SPEs_7_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_8_0.io_index_in_1_0 <= SPEs_7_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_8_0.io_index_in_1_1 <= SPEs_7_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_8_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_8_1.clock <= clock
    SPEs_8_1.reset <= reset
    SPEs_8_1.io_left_in_0_0 <= SPEs_8_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_0_1 <= SPEs_8_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_0_2 <= SPEs_8_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_0_3 <= SPEs_8_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_1_0 <= SPEs_8_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_1_1 <= SPEs_8_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_1_2 <= SPEs_8_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_left_in_1_3 <= SPEs_8_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_8_1.io_up_in_0_0 <= SPEs_7_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_8_1.io_up_in_0_1 <= SPEs_7_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_8_1.io_up_in_1_0 <= SPEs_7_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_8_1.io_up_in_1_1 <= SPEs_7_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_8_1.io_weight_in_0_0 <= SPEs_7_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_8_1.io_weight_in_0_1 <= SPEs_7_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_8_1.io_weight_in_1_0 <= SPEs_7_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_8_1.io_weight_in_1_1 <= SPEs_7_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_8_1.io_index_in_0_0 <= SPEs_7_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_8_1.io_index_in_0_1 <= SPEs_7_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_8_1.io_index_in_1_0 <= SPEs_7_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_8_1.io_index_in_1_1 <= SPEs_7_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_8_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_9_0.clock <= clock
    SPEs_9_0.reset <= reset
    SPEs_9_0.io_left_in_0_0 <= io_left_in_9_0_0 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_0_1 <= io_left_in_9_0_1 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_0_2 <= io_left_in_9_0_2 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_0_3 <= io_left_in_9_0_3 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_1_0 <= io_left_in_9_1_0 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_1_1 <= io_left_in_9_1_1 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_1_2 <= io_left_in_9_1_2 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_left_in_1_3 <= io_left_in_9_1_3 @[vegeta_sa.scala 23:39]
    SPEs_9_0.io_up_in_0_0 <= SPEs_8_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_9_0.io_up_in_0_1 <= SPEs_8_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_9_0.io_up_in_1_0 <= SPEs_8_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_9_0.io_up_in_1_1 <= SPEs_8_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_9_0.io_weight_in_0_0 <= SPEs_8_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_9_0.io_weight_in_0_1 <= SPEs_8_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_9_0.io_weight_in_1_0 <= SPEs_8_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_9_0.io_weight_in_1_1 <= SPEs_8_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_9_0.io_index_in_0_0 <= SPEs_8_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_9_0.io_index_in_0_1 <= SPEs_8_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_9_0.io_index_in_1_0 <= SPEs_8_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_9_0.io_index_in_1_1 <= SPEs_8_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_9_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_9_1.clock <= clock
    SPEs_9_1.reset <= reset
    SPEs_9_1.io_left_in_0_0 <= SPEs_9_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_0_1 <= SPEs_9_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_0_2 <= SPEs_9_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_0_3 <= SPEs_9_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_1_0 <= SPEs_9_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_1_1 <= SPEs_9_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_1_2 <= SPEs_9_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_left_in_1_3 <= SPEs_9_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_9_1.io_up_in_0_0 <= SPEs_8_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_9_1.io_up_in_0_1 <= SPEs_8_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_9_1.io_up_in_1_0 <= SPEs_8_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_9_1.io_up_in_1_1 <= SPEs_8_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_9_1.io_weight_in_0_0 <= SPEs_8_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_9_1.io_weight_in_0_1 <= SPEs_8_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_9_1.io_weight_in_1_0 <= SPEs_8_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_9_1.io_weight_in_1_1 <= SPEs_8_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_9_1.io_index_in_0_0 <= SPEs_8_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_9_1.io_index_in_0_1 <= SPEs_8_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_9_1.io_index_in_1_0 <= SPEs_8_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_9_1.io_index_in_1_1 <= SPEs_8_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_9_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_10_0.clock <= clock
    SPEs_10_0.reset <= reset
    SPEs_10_0.io_left_in_0_0 <= io_left_in_10_0_0 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_0_1 <= io_left_in_10_0_1 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_0_2 <= io_left_in_10_0_2 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_0_3 <= io_left_in_10_0_3 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_1_0 <= io_left_in_10_1_0 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_1_1 <= io_left_in_10_1_1 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_1_2 <= io_left_in_10_1_2 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_left_in_1_3 <= io_left_in_10_1_3 @[vegeta_sa.scala 23:39]
    SPEs_10_0.io_up_in_0_0 <= SPEs_9_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_10_0.io_up_in_0_1 <= SPEs_9_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_10_0.io_up_in_1_0 <= SPEs_9_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_10_0.io_up_in_1_1 <= SPEs_9_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_10_0.io_weight_in_0_0 <= SPEs_9_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_10_0.io_weight_in_0_1 <= SPEs_9_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_10_0.io_weight_in_1_0 <= SPEs_9_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_10_0.io_weight_in_1_1 <= SPEs_9_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_10_0.io_index_in_0_0 <= SPEs_9_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_10_0.io_index_in_0_1 <= SPEs_9_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_10_0.io_index_in_1_0 <= SPEs_9_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_10_0.io_index_in_1_1 <= SPEs_9_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_10_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_10_1.clock <= clock
    SPEs_10_1.reset <= reset
    SPEs_10_1.io_left_in_0_0 <= SPEs_10_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_0_1 <= SPEs_10_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_0_2 <= SPEs_10_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_0_3 <= SPEs_10_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_1_0 <= SPEs_10_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_1_1 <= SPEs_10_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_1_2 <= SPEs_10_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_left_in_1_3 <= SPEs_10_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_10_1.io_up_in_0_0 <= SPEs_9_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_10_1.io_up_in_0_1 <= SPEs_9_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_10_1.io_up_in_1_0 <= SPEs_9_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_10_1.io_up_in_1_1 <= SPEs_9_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_10_1.io_weight_in_0_0 <= SPEs_9_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_10_1.io_weight_in_0_1 <= SPEs_9_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_10_1.io_weight_in_1_0 <= SPEs_9_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_10_1.io_weight_in_1_1 <= SPEs_9_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_10_1.io_index_in_0_0 <= SPEs_9_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_10_1.io_index_in_0_1 <= SPEs_9_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_10_1.io_index_in_1_0 <= SPEs_9_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_10_1.io_index_in_1_1 <= SPEs_9_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_10_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_11_0.clock <= clock
    SPEs_11_0.reset <= reset
    SPEs_11_0.io_left_in_0_0 <= io_left_in_11_0_0 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_0_1 <= io_left_in_11_0_1 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_0_2 <= io_left_in_11_0_2 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_0_3 <= io_left_in_11_0_3 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_1_0 <= io_left_in_11_1_0 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_1_1 <= io_left_in_11_1_1 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_1_2 <= io_left_in_11_1_2 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_left_in_1_3 <= io_left_in_11_1_3 @[vegeta_sa.scala 23:39]
    SPEs_11_0.io_up_in_0_0 <= SPEs_10_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_11_0.io_up_in_0_1 <= SPEs_10_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_11_0.io_up_in_1_0 <= SPEs_10_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_11_0.io_up_in_1_1 <= SPEs_10_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_11_0.io_weight_in_0_0 <= SPEs_10_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_11_0.io_weight_in_0_1 <= SPEs_10_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_11_0.io_weight_in_1_0 <= SPEs_10_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_11_0.io_weight_in_1_1 <= SPEs_10_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_11_0.io_index_in_0_0 <= SPEs_10_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_11_0.io_index_in_0_1 <= SPEs_10_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_11_0.io_index_in_1_0 <= SPEs_10_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_11_0.io_index_in_1_1 <= SPEs_10_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_11_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_11_1.clock <= clock
    SPEs_11_1.reset <= reset
    SPEs_11_1.io_left_in_0_0 <= SPEs_11_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_0_1 <= SPEs_11_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_0_2 <= SPEs_11_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_0_3 <= SPEs_11_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_1_0 <= SPEs_11_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_1_1 <= SPEs_11_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_1_2 <= SPEs_11_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_left_in_1_3 <= SPEs_11_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_11_1.io_up_in_0_0 <= SPEs_10_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_11_1.io_up_in_0_1 <= SPEs_10_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_11_1.io_up_in_1_0 <= SPEs_10_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_11_1.io_up_in_1_1 <= SPEs_10_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_11_1.io_weight_in_0_0 <= SPEs_10_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_11_1.io_weight_in_0_1 <= SPEs_10_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_11_1.io_weight_in_1_0 <= SPEs_10_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_11_1.io_weight_in_1_1 <= SPEs_10_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_11_1.io_index_in_0_0 <= SPEs_10_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_11_1.io_index_in_0_1 <= SPEs_10_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_11_1.io_index_in_1_0 <= SPEs_10_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_11_1.io_index_in_1_1 <= SPEs_10_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_11_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_12_0.clock <= clock
    SPEs_12_0.reset <= reset
    SPEs_12_0.io_left_in_0_0 <= io_left_in_12_0_0 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_0_1 <= io_left_in_12_0_1 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_0_2 <= io_left_in_12_0_2 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_0_3 <= io_left_in_12_0_3 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_1_0 <= io_left_in_12_1_0 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_1_1 <= io_left_in_12_1_1 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_1_2 <= io_left_in_12_1_2 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_left_in_1_3 <= io_left_in_12_1_3 @[vegeta_sa.scala 23:39]
    SPEs_12_0.io_up_in_0_0 <= SPEs_11_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_12_0.io_up_in_0_1 <= SPEs_11_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_12_0.io_up_in_1_0 <= SPEs_11_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_12_0.io_up_in_1_1 <= SPEs_11_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_12_0.io_weight_in_0_0 <= SPEs_11_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_12_0.io_weight_in_0_1 <= SPEs_11_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_12_0.io_weight_in_1_0 <= SPEs_11_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_12_0.io_weight_in_1_1 <= SPEs_11_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_12_0.io_index_in_0_0 <= SPEs_11_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_12_0.io_index_in_0_1 <= SPEs_11_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_12_0.io_index_in_1_0 <= SPEs_11_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_12_0.io_index_in_1_1 <= SPEs_11_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_12_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_12_1.clock <= clock
    SPEs_12_1.reset <= reset
    SPEs_12_1.io_left_in_0_0 <= SPEs_12_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_0_1 <= SPEs_12_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_0_2 <= SPEs_12_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_0_3 <= SPEs_12_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_1_0 <= SPEs_12_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_1_1 <= SPEs_12_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_1_2 <= SPEs_12_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_left_in_1_3 <= SPEs_12_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_12_1.io_up_in_0_0 <= SPEs_11_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_12_1.io_up_in_0_1 <= SPEs_11_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_12_1.io_up_in_1_0 <= SPEs_11_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_12_1.io_up_in_1_1 <= SPEs_11_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_12_1.io_weight_in_0_0 <= SPEs_11_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_12_1.io_weight_in_0_1 <= SPEs_11_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_12_1.io_weight_in_1_0 <= SPEs_11_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_12_1.io_weight_in_1_1 <= SPEs_11_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_12_1.io_index_in_0_0 <= SPEs_11_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_12_1.io_index_in_0_1 <= SPEs_11_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_12_1.io_index_in_1_0 <= SPEs_11_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_12_1.io_index_in_1_1 <= SPEs_11_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_12_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_13_0.clock <= clock
    SPEs_13_0.reset <= reset
    SPEs_13_0.io_left_in_0_0 <= io_left_in_13_0_0 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_0_1 <= io_left_in_13_0_1 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_0_2 <= io_left_in_13_0_2 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_0_3 <= io_left_in_13_0_3 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_1_0 <= io_left_in_13_1_0 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_1_1 <= io_left_in_13_1_1 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_1_2 <= io_left_in_13_1_2 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_left_in_1_3 <= io_left_in_13_1_3 @[vegeta_sa.scala 23:39]
    SPEs_13_0.io_up_in_0_0 <= SPEs_12_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_13_0.io_up_in_0_1 <= SPEs_12_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_13_0.io_up_in_1_0 <= SPEs_12_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_13_0.io_up_in_1_1 <= SPEs_12_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_13_0.io_weight_in_0_0 <= SPEs_12_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_13_0.io_weight_in_0_1 <= SPEs_12_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_13_0.io_weight_in_1_0 <= SPEs_12_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_13_0.io_weight_in_1_1 <= SPEs_12_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_13_0.io_index_in_0_0 <= SPEs_12_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_13_0.io_index_in_0_1 <= SPEs_12_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_13_0.io_index_in_1_0 <= SPEs_12_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_13_0.io_index_in_1_1 <= SPEs_12_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_13_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_13_1.clock <= clock
    SPEs_13_1.reset <= reset
    SPEs_13_1.io_left_in_0_0 <= SPEs_13_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_0_1 <= SPEs_13_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_0_2 <= SPEs_13_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_0_3 <= SPEs_13_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_1_0 <= SPEs_13_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_1_1 <= SPEs_13_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_1_2 <= SPEs_13_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_left_in_1_3 <= SPEs_13_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_13_1.io_up_in_0_0 <= SPEs_12_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_13_1.io_up_in_0_1 <= SPEs_12_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_13_1.io_up_in_1_0 <= SPEs_12_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_13_1.io_up_in_1_1 <= SPEs_12_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_13_1.io_weight_in_0_0 <= SPEs_12_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_13_1.io_weight_in_0_1 <= SPEs_12_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_13_1.io_weight_in_1_0 <= SPEs_12_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_13_1.io_weight_in_1_1 <= SPEs_12_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_13_1.io_index_in_0_0 <= SPEs_12_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_13_1.io_index_in_0_1 <= SPEs_12_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_13_1.io_index_in_1_0 <= SPEs_12_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_13_1.io_index_in_1_1 <= SPEs_12_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_13_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_14_0.clock <= clock
    SPEs_14_0.reset <= reset
    SPEs_14_0.io_left_in_0_0 <= io_left_in_14_0_0 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_0_1 <= io_left_in_14_0_1 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_0_2 <= io_left_in_14_0_2 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_0_3 <= io_left_in_14_0_3 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_1_0 <= io_left_in_14_1_0 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_1_1 <= io_left_in_14_1_1 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_1_2 <= io_left_in_14_1_2 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_left_in_1_3 <= io_left_in_14_1_3 @[vegeta_sa.scala 23:39]
    SPEs_14_0.io_up_in_0_0 <= SPEs_13_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_14_0.io_up_in_0_1 <= SPEs_13_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_14_0.io_up_in_1_0 <= SPEs_13_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_14_0.io_up_in_1_1 <= SPEs_13_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_14_0.io_weight_in_0_0 <= SPEs_13_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_14_0.io_weight_in_0_1 <= SPEs_13_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_14_0.io_weight_in_1_0 <= SPEs_13_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_14_0.io_weight_in_1_1 <= SPEs_13_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_14_0.io_index_in_0_0 <= SPEs_13_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_14_0.io_index_in_0_1 <= SPEs_13_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_14_0.io_index_in_1_0 <= SPEs_13_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_14_0.io_index_in_1_1 <= SPEs_13_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_14_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_14_1.clock <= clock
    SPEs_14_1.reset <= reset
    SPEs_14_1.io_left_in_0_0 <= SPEs_14_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_0_1 <= SPEs_14_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_0_2 <= SPEs_14_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_0_3 <= SPEs_14_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_1_0 <= SPEs_14_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_1_1 <= SPEs_14_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_1_2 <= SPEs_14_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_left_in_1_3 <= SPEs_14_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_14_1.io_up_in_0_0 <= SPEs_13_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_14_1.io_up_in_0_1 <= SPEs_13_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_14_1.io_up_in_1_0 <= SPEs_13_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_14_1.io_up_in_1_1 <= SPEs_13_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_14_1.io_weight_in_0_0 <= SPEs_13_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_14_1.io_weight_in_0_1 <= SPEs_13_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_14_1.io_weight_in_1_0 <= SPEs_13_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_14_1.io_weight_in_1_1 <= SPEs_13_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_14_1.io_index_in_0_0 <= SPEs_13_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_14_1.io_index_in_0_1 <= SPEs_13_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_14_1.io_index_in_1_0 <= SPEs_13_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_14_1.io_index_in_1_1 <= SPEs_13_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_14_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_15_0.clock <= clock
    SPEs_15_0.reset <= reset
    SPEs_15_0.io_left_in_0_0 <= io_left_in_15_0_0 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_0_1 <= io_left_in_15_0_1 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_0_2 <= io_left_in_15_0_2 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_0_3 <= io_left_in_15_0_3 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_1_0 <= io_left_in_15_1_0 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_1_1 <= io_left_in_15_1_1 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_1_2 <= io_left_in_15_1_2 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_left_in_1_3 <= io_left_in_15_1_3 @[vegeta_sa.scala 23:39]
    SPEs_15_0.io_up_in_0_0 <= SPEs_14_0.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_15_0.io_up_in_0_1 <= SPEs_14_0.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_15_0.io_up_in_1_0 <= SPEs_14_0.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_15_0.io_up_in_1_1 <= SPEs_14_0.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_15_0.io_weight_in_0_0 <= SPEs_14_0.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_15_0.io_weight_in_0_1 <= SPEs_14_0.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_15_0.io_weight_in_1_0 <= SPEs_14_0.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_15_0.io_weight_in_1_1 <= SPEs_14_0.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_15_0.io_index_in_0_0 <= SPEs_14_0.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_15_0.io_index_in_0_1 <= SPEs_14_0.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_15_0.io_index_in_1_0 <= SPEs_14_0.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_15_0.io_index_in_1_1 <= SPEs_14_0.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_15_0.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
    SPEs_15_1.clock <= clock
    SPEs_15_1.reset <= reset
    SPEs_15_1.io_left_in_0_0 <= SPEs_15_0.io_right_out_0_0 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_0_1 <= SPEs_15_0.io_right_out_0_1 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_0_2 <= SPEs_15_0.io_right_out_0_2 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_0_3 <= SPEs_15_0.io_right_out_0_3 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_1_0 <= SPEs_15_0.io_right_out_1_0 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_1_1 <= SPEs_15_0.io_right_out_1_1 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_1_2 <= SPEs_15_0.io_right_out_1_2 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_left_in_1_3 <= SPEs_15_0.io_right_out_1_3 @[vegeta_sa.scala 25:39]
    SPEs_15_1.io_up_in_0_0 <= SPEs_14_1.io_down_out_0_0 @[vegeta_sa.scala 35:37]
    SPEs_15_1.io_up_in_0_1 <= SPEs_14_1.io_down_out_0_1 @[vegeta_sa.scala 35:37]
    SPEs_15_1.io_up_in_1_0 <= SPEs_14_1.io_down_out_1_0 @[vegeta_sa.scala 35:37]
    SPEs_15_1.io_up_in_1_1 <= SPEs_14_1.io_down_out_1_1 @[vegeta_sa.scala 35:37]
    SPEs_15_1.io_weight_in_0_0 <= SPEs_14_1.io_weight_out_0_0 @[vegeta_sa.scala 33:41]
    SPEs_15_1.io_weight_in_0_1 <= SPEs_14_1.io_weight_out_0_1 @[vegeta_sa.scala 33:41]
    SPEs_15_1.io_weight_in_1_0 <= SPEs_14_1.io_weight_out_1_0 @[vegeta_sa.scala 33:41]
    SPEs_15_1.io_weight_in_1_1 <= SPEs_14_1.io_weight_out_1_1 @[vegeta_sa.scala 33:41]
    SPEs_15_1.io_index_in_0_0 <= SPEs_14_1.io_index_out_0_0 @[vegeta_sa.scala 34:40]
    SPEs_15_1.io_index_in_0_1 <= SPEs_14_1.io_index_out_0_1 @[vegeta_sa.scala 34:40]
    SPEs_15_1.io_index_in_1_0 <= SPEs_14_1.io_index_out_1_0 @[vegeta_sa.scala 34:40]
    SPEs_15_1.io_index_in_1_1 <= SPEs_14_1.io_index_out_1_1 @[vegeta_sa.scala 34:40]
    SPEs_15_1.io_weight_load_en <= io_weight_load_en @[vegeta_sa.scala 20:42]
