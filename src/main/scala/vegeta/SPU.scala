package vegeta
import chisel3._

// SPU
class SPU(num_mac : Int) extends Module {
    val io = IO(new Bundle {
        val left_in = Input(Vec(num_mac, new data_block(num_mac)))
        val up_in = Input(Vec(num_mac, SInt(32.W)))
        val weight_in = Input(Vec(num_mac, SInt(32.W)))
        val index_in = Input(Vec(num_mac, UInt(2.W)))
        val down_out = Output(Vec(num_mac, SInt(32.W)))
        val weight_buffer_out = Output(Vec(num_mac, SInt(32.W)))
    })
    val weight_buffer = Reg(Vec(num_mac, SInt(32.W)))
    io.weight_buffer_out := weight_buffer
    val weight_index = Reg(Vec(num_mac, UInt(2.W)))
    weight_buffer := io.weight_in
    weight_index := io.index_in
    val res = Reg(Vec(num_mac, SInt(32.W)))
    for(i <- 0 until num_mac)
        res(i) := weight_buffer(i) * io.left_in(i).data(weight_index(i)) + io.up_in(i)

    io.down_out := res
}