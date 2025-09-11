circuit SPE :
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
    output io_weight_out_0 : SInt<32>
    output io_weight_out_1 : SInt<32>
    output io_index_out_0 : UInt<2>
    output io_index_out_1 : UInt<2>
    output io_down_out_0 : SInt<32>
    output io_down_out_1 : SInt<32>

    reg weight_buffer_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), weight_buffer_0) @[SPU.scala 17:28]
    reg weight_buffer_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), weight_buffer_1) @[SPU.scala 17:28]
    reg weight_index_0 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), weight_index_0) @[SPU.scala 18:27]
    reg weight_index_1 : UInt<2>, clock with :
      reset => (UInt<1>("h0"), weight_index_1) @[SPU.scala 18:27]
    reg res_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), res_0) @[SPU.scala 21:18]
    reg res_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), res_1) @[SPU.scala 21:18]
    node _GEN_0 = validif(eq(UInt<1>("h0"), weight_index_0), io_left_in_0_0) @[SPU.scala 23:{36,36}]
    node _GEN_1 = mux(eq(UInt<1>("h1"), weight_index_0), io_left_in_0_1, _GEN_0) @[SPU.scala 23:{36,36}]
    node _GEN_2 = mux(eq(UInt<2>("h2"), weight_index_0), io_left_in_0_2, _GEN_1) @[SPU.scala 23:{36,36}]
    node _GEN_3 = mux(eq(UInt<2>("h3"), weight_index_0), io_left_in_0_3, _GEN_2) @[SPU.scala 23:{36,36}]
    node _io_left_in_0_weight_index_0 = _GEN_3 @[SPU.scala 23:36]
    node _res_0_T = mul(weight_buffer_0, _io_left_in_0_weight_index_0) @[SPU.scala 23:36]
    node _res_0_T_1 = add(_res_0_T, io_up_in_0) @[SPU.scala 23:69]
    node _res_0_T_2 = tail(_res_0_T_1, 1) @[SPU.scala 23:69]
    node _res_0_T_3 = asSInt(_res_0_T_2) @[SPU.scala 23:69]
    node _GEN_4 = validif(eq(UInt<1>("h0"), weight_index_1), io_left_in_1_0) @[SPU.scala 23:{36,36}]
    node _GEN_5 = mux(eq(UInt<1>("h1"), weight_index_1), io_left_in_1_1, _GEN_4) @[SPU.scala 23:{36,36}]
    node _GEN_6 = mux(eq(UInt<2>("h2"), weight_index_1), io_left_in_1_2, _GEN_5) @[SPU.scala 23:{36,36}]
    node _GEN_7 = mux(eq(UInt<2>("h3"), weight_index_1), io_left_in_1_3, _GEN_6) @[SPU.scala 23:{36,36}]
    node _io_left_in_1_weight_index_1 = _GEN_7 @[SPU.scala 23:36]
    node _res_1_T = mul(weight_buffer_1, _io_left_in_1_weight_index_1) @[SPU.scala 23:36]
    node _res_1_T_1 = add(_res_1_T, io_up_in_1) @[SPU.scala 23:69]
    node _res_1_T_2 = tail(_res_1_T_1, 1) @[SPU.scala 23:69]
    node _res_1_T_3 = asSInt(_res_1_T_2) @[SPU.scala 23:69]
    io_weight_out_0 <= weight_buffer_0 @[SPU.scala 25:19]
    io_weight_out_1 <= weight_buffer_1 @[SPU.scala 25:19]
    io_index_out_0 <= weight_index_0 @[SPU.scala 26:18]
    io_index_out_1 <= weight_index_1 @[SPU.scala 26:18]
    io_down_out_0 <= res_0 @[SPU.scala 27:17]
    io_down_out_1 <= res_1 @[SPU.scala 27:17]
    weight_buffer_0 <= io_weight_in_0 @[SPU.scala 19:19]
    weight_buffer_1 <= io_weight_in_1 @[SPU.scala 19:19]
    weight_index_0 <= io_index_in_0 @[SPU.scala 20:18]
    weight_index_1 <= io_index_in_1 @[SPU.scala 20:18]
    res_0 <= asSInt(bits(_res_0_T_3, 31, 0)) @[SPU.scala 23:16]
    res_1 <= asSInt(bits(_res_1_T_3, 31, 0)) @[SPU.scala 23:16]

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

    inst SPUs_0 of SPU @[SPE.scala 18:49]
    inst SPUs_1 of SPU @[SPE.scala 18:49]
    reg rigth_out_buffer_0_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_0) @[SPE.scala 28:31]
    reg rigth_out_buffer_0_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_1) @[SPE.scala 28:31]
    reg rigth_out_buffer_0_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_2) @[SPE.scala 28:31]
    reg rigth_out_buffer_0_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_0_3) @[SPE.scala 28:31]
    reg rigth_out_buffer_1_0 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_0) @[SPE.scala 28:31]
    reg rigth_out_buffer_1_1 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_1) @[SPE.scala 28:31]
    reg rigth_out_buffer_1_2 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_2) @[SPE.scala 28:31]
    reg rigth_out_buffer_1_3 : SInt<32>, clock with :
      reset => (UInt<1>("h0"), rigth_out_buffer_1_3) @[SPE.scala 28:31]
    io_right_out_0_0 <= rigth_out_buffer_0_0 @[SPE.scala 30:18]
    io_right_out_0_1 <= rigth_out_buffer_0_1 @[SPE.scala 30:18]
    io_right_out_0_2 <= rigth_out_buffer_0_2 @[SPE.scala 30:18]
    io_right_out_0_3 <= rigth_out_buffer_0_3 @[SPE.scala 30:18]
    io_right_out_1_0 <= rigth_out_buffer_1_0 @[SPE.scala 30:18]
    io_right_out_1_1 <= rigth_out_buffer_1_1 @[SPE.scala 30:18]
    io_right_out_1_2 <= rigth_out_buffer_1_2 @[SPE.scala 30:18]
    io_right_out_1_3 <= rigth_out_buffer_1_3 @[SPE.scala 30:18]
    io_weight_out_0_0 <= SPUs_0.io_weight_out_0 @[SPE.scala 24:26]
    io_weight_out_0_1 <= SPUs_0.io_weight_out_1 @[SPE.scala 24:26]
    io_weight_out_1_0 <= SPUs_1.io_weight_out_0 @[SPE.scala 24:26]
    io_weight_out_1_1 <= SPUs_1.io_weight_out_1 @[SPE.scala 24:26]
    io_index_out_0_0 <= SPUs_0.io_index_out_0 @[SPE.scala 25:25]
    io_index_out_0_1 <= SPUs_0.io_index_out_1 @[SPE.scala 25:25]
    io_index_out_1_0 <= SPUs_1.io_index_out_0 @[SPE.scala 25:25]
    io_index_out_1_1 <= SPUs_1.io_index_out_1 @[SPE.scala 25:25]
    io_down_out_0_0 <= SPUs_0.io_down_out_0 @[SPE.scala 26:24]
    io_down_out_0_1 <= SPUs_0.io_down_out_1 @[SPE.scala 26:24]
    io_down_out_1_0 <= SPUs_1.io_down_out_0 @[SPE.scala 26:24]
    io_down_out_1_1 <= SPUs_1.io_down_out_1 @[SPE.scala 26:24]
    SPUs_0.clock <= clock
    SPUs_0.reset <= reset
    SPUs_0.io_left_in_0_0 <= io_left_in_0_0 @[SPE.scala 20:28]
    SPUs_0.io_left_in_0_1 <= io_left_in_0_1 @[SPE.scala 20:28]
    SPUs_0.io_left_in_0_2 <= io_left_in_0_2 @[SPE.scala 20:28]
    SPUs_0.io_left_in_0_3 <= io_left_in_0_3 @[SPE.scala 20:28]
    SPUs_0.io_left_in_1_0 <= io_left_in_1_0 @[SPE.scala 20:28]
    SPUs_0.io_left_in_1_1 <= io_left_in_1_1 @[SPE.scala 20:28]
    SPUs_0.io_left_in_1_2 <= io_left_in_1_2 @[SPE.scala 20:28]
    SPUs_0.io_left_in_1_3 <= io_left_in_1_3 @[SPE.scala 20:28]
    SPUs_0.io_up_in_0 <= io_up_in_0_0 @[SPE.scala 21:26]
    SPUs_0.io_up_in_1 <= io_up_in_0_1 @[SPE.scala 21:26]
    SPUs_0.io_weight_in_0 <= io_weight_in_0_0 @[SPE.scala 22:30]
    SPUs_0.io_weight_in_1 <= io_weight_in_0_1 @[SPE.scala 22:30]
    SPUs_0.io_index_in_0 <= io_index_in_0_0 @[SPE.scala 23:29]
    SPUs_0.io_index_in_1 <= io_index_in_0_1 @[SPE.scala 23:29]
    SPUs_1.clock <= clock
    SPUs_1.reset <= reset
    SPUs_1.io_left_in_0_0 <= io_left_in_0_0 @[SPE.scala 20:28]
    SPUs_1.io_left_in_0_1 <= io_left_in_0_1 @[SPE.scala 20:28]
    SPUs_1.io_left_in_0_2 <= io_left_in_0_2 @[SPE.scala 20:28]
    SPUs_1.io_left_in_0_3 <= io_left_in_0_3 @[SPE.scala 20:28]
    SPUs_1.io_left_in_1_0 <= io_left_in_1_0 @[SPE.scala 20:28]
    SPUs_1.io_left_in_1_1 <= io_left_in_1_1 @[SPE.scala 20:28]
    SPUs_1.io_left_in_1_2 <= io_left_in_1_2 @[SPE.scala 20:28]
    SPUs_1.io_left_in_1_3 <= io_left_in_1_3 @[SPE.scala 20:28]
    SPUs_1.io_up_in_0 <= io_up_in_1_0 @[SPE.scala 21:26]
    SPUs_1.io_up_in_1 <= io_up_in_1_1 @[SPE.scala 21:26]
    SPUs_1.io_weight_in_0 <= io_weight_in_1_0 @[SPE.scala 22:30]
    SPUs_1.io_weight_in_1 <= io_weight_in_1_1 @[SPE.scala 22:30]
    SPUs_1.io_index_in_0 <= io_index_in_1_0 @[SPE.scala 23:29]
    SPUs_1.io_index_in_1 <= io_index_in_1_1 @[SPE.scala 23:29]
    rigth_out_buffer_0_0 <= io_left_in_0_0 @[SPE.scala 29:22]
    rigth_out_buffer_0_1 <= io_left_in_0_1 @[SPE.scala 29:22]
    rigth_out_buffer_0_2 <= io_left_in_0_2 @[SPE.scala 29:22]
    rigth_out_buffer_0_3 <= io_left_in_0_3 @[SPE.scala 29:22]
    rigth_out_buffer_1_0 <= io_left_in_1_0 @[SPE.scala 29:22]
    rigth_out_buffer_1_1 <= io_left_in_1_1 @[SPE.scala 29:22]
    rigth_out_buffer_1_2 <= io_left_in_1_2 @[SPE.scala 29:22]
    rigth_out_buffer_1_3 <= io_left_in_1_3 @[SPE.scala 29:22]
