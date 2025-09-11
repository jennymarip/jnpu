package vegeta
import config._
import chisel3._
import chisel3.util.log2Ceil

class vegeta_sa extends Module {
    val io = IO(new Bundle {
        val left_in = Input(Vec(N_rows, Vec(reduction_factor, Vec(blk_size, SInt(32.W)))))
        val weight_in = Input(Vec(N_cols, Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W)))))
        val index_in = Input(Vec(N_cols, Vec(broadcast_factor, Vec(reduction_factor, SInt(log2Ceil(blk_size).W)))))
        val output = Output(Vec(N_rows, Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W)))))
    })
    val SPEs = Seq.fill(N_rows)(Seq.fill(N_cols)(Module(new SPE)))
    
}