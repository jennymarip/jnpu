package vegeta
import chisel3._

// SPU
// todo 计算逻辑
class SPU(num_mac : Int) extends Module {
    val io = IO(new Bundle {
        val left_in = Input(Vec(num_mac, new data_block(num_mac)))
        val up_in = Input(Vec(num_mac, SInt(32.W)))
        val down_out = Output(Vec(num_mac, SInt(32.W)))
    })
    val weight_buffer = Reg(Vec(num_mac, SInt(32.W)))
    val weight_index = Reg(Vec(num_mac, UInt(2.W)))

    val res = Reg(Vec(num_mac, SInt(32.W)))
    for(i <- 0 until num_mac){
        res(i) := weight_buffer(i) * io.left_in(i).data(weight_index(i)) + io.up_in(i)
    }
    for(i <- 0 until num_mac){
        io.down_out(i) := res(i)
    }
}