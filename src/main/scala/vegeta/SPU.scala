package vegeta
import config._
import chisel3._
import chisel3.util.log2Ceil

// SPU
class SPU extends Module {
    val io = IO(new Bundle {
        val left_in = Input(Vec(reduction_factor, Vec(blk_size, SInt(32.W))))
        val up_in = Input(Vec(reduction_factor, SInt(32.W)))
        val weight_in = Input(Vec(reduction_factor, SInt(32.W)))
        val index_in = Input(Vec(reduction_factor, UInt(log2Ceil(blk_size).W)))
        val weight_load_en = Input(Bool())
        val weight_out = Output(Vec(reduction_factor, SInt(32.W)))
        val index_out = Output(Vec(reduction_factor, UInt(log2Ceil(blk_size).W)))
        val down_out = Output(Vec(reduction_factor, SInt(32.W)))
    })
    val weight_buffer = Reg(Vec(reduction_factor, SInt(32.W)))
    val weight_index = Reg(Vec(reduction_factor, UInt(log2Ceil(blk_size).W)))
    when(io.weight_load_en){
        weight_buffer := io.weight_in
        weight_index := io.index_in
    }
    val res = Reg(Vec(reduction_factor, SInt(32.W)))
    for(i <- 0 until reduction_factor)
        res(i) := weight_buffer(i) * io.left_in(i)(weight_index(i)) + io.up_in(i)

    io.weight_out := weight_buffer
    io.index_out := weight_index
    io.down_out := res
}

/**
 * An object extending App to generate the Verilog code.
 */
object SPU extends App {
  println(getVerilogString(new SPU))
}