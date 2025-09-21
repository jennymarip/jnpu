package vegeta
import config._
import chisel3._
import chisel3.util.log2Ceil

// SPE
class SPE(
    val broadcast_factor: Int = broadcast_factor,
    val reduction_factor: Int = reduction_factor
) extends Module {
    val io = IO(new Bundle {
        val left_in = Input(Vec(reduction_factor, Vec(blk_size, SInt(32.W))))
        val up_in = Input(Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W))))
        val weight_in = Input(Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W))))
        val index_in = Input(Vec(broadcast_factor, Vec(reduction_factor, UInt(log2Ceil(blk_size).W))))
        val weight_load_en = Input(Bool())
        val right_out = Output(Vec(reduction_factor, Vec(blk_size, SInt(32.W))))
        val weight_out = Output(Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W))))
        val index_out = Output(Vec(broadcast_factor, Vec(reduction_factor, UInt(log2Ceil(blk_size).W))))
        val down_out = Output(Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W))))
    })
    val SPUs = Seq.fill(broadcast_factor)(Module(new SPU(reduction_factor)))
    for(i <- 0 until broadcast_factor){
        SPUs(i).io.left_in := io.left_in
        SPUs(i).io.up_in := io.up_in(i)
        SPUs(i).io.weight_in := io.weight_in(i)
        SPUs(i).io.index_in := io.index_in(i)
        SPUs(i).io.weight_load_en := io.weight_load_en
        io.weight_out(i) := SPUs(i).io.weight_out
        io.index_out(i) := SPUs(i).io.index_out
        io.down_out(i) := SPUs(i).io.down_out
    }
    val rigth_out_buffer = Reg(Vec(reduction_factor, Vec(blk_size, SInt(32.W))))
    rigth_out_buffer := io.left_in
    io.right_out := rigth_out_buffer
}

/**
 * An object extending App to generate the Verilog code.
 */
object SPE extends App {
  println(getVerilogString(new SPE))
}