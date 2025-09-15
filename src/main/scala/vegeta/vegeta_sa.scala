package vegeta
import config._
import chisel3._
import chisel3.util.log2Ceil

class vegeta_sa extends Module {
    val io = IO(new Bundle {
        val left_in = Input(Vec(N_rows, Vec(reduction_factor, Vec(blk_size, SInt(32.W)))))
        val weight_in = Input(Vec(N_cols, Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W)))))
        val index_in = Input(Vec(N_cols, Vec(broadcast_factor, Vec(reduction_factor, UInt(log2Ceil(blk_size).W)))))
        val weight_load_en = Input(Bool())
        val output = Output(Vec(N_cols, Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W)))))
        val SPE_output = Output(Vec(N_rows, Vec(N_cols, Vec(broadcast_factor, Vec(reduction_factor, SInt(32.W))))))
    })
    val SPEs = Seq.fill(N_rows)(Seq.fill(N_cols)(Module(new SPE)))
    val input_zero = VecInit(Seq.fill(broadcast_factor)(VecInit(Seq.fill(reduction_factor)(0.S(32.W)))))
    // SPE之间的连线
    for(i <- 0 until N_rows){
        for (j <- 0 until N_cols){
            SPEs(i)(j).io.weight_load_en := io.weight_load_en
            // 输入块传递
            if(j == 0){
                SPEs(i)(j).io.left_in := io.left_in(i)
            } else{
                SPEs(i)(j).io.left_in := SPEs(i)(j-1).io.right_out
            }
            // 驻留元素 & 部分和传递
            if(i == 0){
                SPEs(i)(j).io.weight_in := io.weight_in(j)
                SPEs(i)(j).io.index_in := io.index_in(j)
                SPEs(i)(j).io.up_in := input_zero
            } else {
                SPEs(i)(j).io.weight_in := SPEs(i-1)(j).io.weight_out
                SPEs(i)(j).io.index_in := SPEs(i-1)(j).io.index_out
                SPEs(i)(j).io.up_in := SPEs(i-1)(j).io.down_out
            }
        }
    }
    // 输出
    for(i <- 0 until N_cols){
        for(j <- 0 until broadcast_factor){
            for(k <- 0 until reduction_factor)
                io.output(i)(j)(k) := SPEs(N_rows-1)(i).io.down_out(j)(k)
        }
    }
    for(i <- 0 until N_rows){
        for(j <- 0 until N_cols){
            io.SPE_output(i)(j) := SPEs(i)(j).io.down_out
        }
    }
}