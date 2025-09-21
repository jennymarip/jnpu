package vegeta
import config._
import chisel3._
import chisel3.util.log2Ceil
// vegeta of unstructure sparse(three types SPE)
class vegeta_sa_unstructure extends Module{
    val io = IO(new Bundle {
        val left_in = Input(Vec(N_rows, Vec(blk_size, SInt(32.W))))
        val weight_in = Input(Vec(N_cols1+N_cols2+N_cols3, Vec(blk_size, SInt(32.W))))
        val index_in = Input(Vec(N_cols1+N_cols2+N_cols3, Vec(blk_size, UInt(log2Ceil(blk_size).W))))
        val weight_load_en = Input(Bool())
        val output = Output(Vec(N_cols1+N_cols2+N_cols3, Vec(blk_size, SInt(32.W))))
    })
    // SPEs_1 -> SPEs_2 -> SPEs_3
    val SPEs_1 = Seq.fill(N_rows)(Seq.fill(N_cols1)(Module(new SPE(1, blk_size))))
    val SPEs_2 = Seq.fill(N_rows)(Seq.fill(N_cols2)(Module(new SPE(2, blk_size/2))))
    val SPEs_3 = Seq.fill(N_rows)(Seq.fill(N_cols3)(Module(new SPE(blk_size, 1))))
    val input_zero1 = VecInit(Seq.fill(1)(VecInit(Seq.fill(blk_size)(0.S(32.W)))))
    val input_zero2 = VecInit(Seq.fill(2)(VecInit(Seq.fill(blk_size/2)(0.S(32.W)))))
    val input_zero3 = VecInit(Seq.fill(blk_size)(VecInit(Seq.fill(1)(0.S(32.W)))))
    // wiring
    for(i <- 0 until N_rows){
        // 输入块传递
        for(j <- 0 until N_cols1){
            SPEs_1(i)(j).io.weight_load_en := io.weight_load_en
            if (j == 0){
                for(k <- 0 until blk_size)
                    SPEs_1(i)(j).io.left_in(k) := io.left_in(i)
            } else {
                SPEs_1(i)(j).io.left_in := SPEs_1(i)(j-1).io.left_in
            }
        }
        for(j <- 0 until N_cols2){
            SPEs_2(i)(j).io.weight_load_en := io.weight_load_en
            if (j == 0){
                for(k <- 0 until 2)
                    SPEs_2(i)(j).io.left_in(k) := SPEs_1(i)(N_cols1-1).io.right_out(0)
            } else {
                SPEs_2(i)(j).io.left_in := SPEs_2(i)(j-1).io.left_in
            }
        }
        for(j <- 0 until N_cols3){
            SPEs_3(i)(j).io.weight_load_en := io.weight_load_en
            if (j == 0){
                SPEs_3(i)(j).io.left_in(0) := SPEs_2(i)(N_cols2-1).io.right_out(0)
            } else {
                SPEs_3(i)(j).io.left_in := SPEs_3(i)(j-1).io.left_in
            }
        }
        // 驻留元素 & 部分和传递
        if(i == 0){
            for(j <- 0 until N_cols1){
                SPEs_1(i)(j).io.weight_in(0) := io.weight_in(j)
                SPEs_1(i)(j).io.index_in(0) := io.index_in(j)
                SPEs_1(i)(j).io.up_in := input_zero1
            }
            for(j <- 0 until N_cols2){
                for(k <- 0 until 2){
                    for(t <- 0 until blk_size/2){
                        SPEs_2(i)(j).io.weight_in(k)(t) := io.weight_in(N_cols1+j)(k*2+t)
                        SPEs_2(i)(j).io.index_in(k)(t) := io.index_in(N_cols1+j)(k*2+t)
                    }
                }
                SPEs_2(i)(j).io.up_in := input_zero2
            }
            for(j <- 0 until N_cols3){
                for(k <- 0 until blk_size){
                    SPEs_3(i)(j).io.weight_in(k)(0) := io.weight_in(N_cols1+N_cols2+j)(k)
                    SPEs_3(i)(j).io.index_in(k)(0) := io.index_in(N_cols1+N_cols2+j)(k)
                }
                SPEs_3(i)(j).io.up_in := input_zero3
            }
        }else{
            for(j <- 0 until N_cols1){
                SPEs_1(i)(j).io.weight_in := SPEs_1(i-1)(j).io.weight_out
                SPEs_1(i)(j).io.index_in := SPEs_1(i-1)(j).io.index_out
                SPEs_1(i)(j).io.up_in := SPEs_1(i-1)(j).io.down_out
            }
            for(j <- 0 until N_cols2){
                SPEs_2(i)(j).io.weight_in := SPEs_2(i-1)(j).io.weight_out
                SPEs_2(i)(j).io.index_in := SPEs_2(i-1)(j).io.index_out
                SPEs_2(i)(j).io.up_in := SPEs_2(i-1)(j).io.down_out
            }
            for(j <- 0 until N_cols3){
                SPEs_3(i)(j).io.weight_in := SPEs_3(i-1)(j).io.weight_out
                SPEs_3(i)(j).io.index_in := SPEs_3(i-1)(j).io.index_out
                SPEs_3(i)(j).io.up_in := SPEs_3(i-1)(j).io.down_out
            }
        }
    }
    // 输出
    for(i <- 0 until N_cols1)
        io.output(i) := SPEs_1(N_rows-1)(i).io.down_out(0)
    for(i <- 0 until N_cols2){
        for(j <- 0 until 2){
            for(k <- 0 until blk_size/2)
                io.output(N_cols1+i)(j*2+k) := SPEs_2(N_rows-1)(i).io.down_out(j)(k)
        }
    }
    for(i <- 0 until N_cols3){
        for(j <- 0 until blk_size)
            io.output(N_cols1+N_cols2+i)(j) := SPEs_3(N_rows-1)(i).io.down_out(j)(0)
    }
}

object vageta_sa_unstructure extends App {
  println(getVerilogString(new vegeta_sa_unstructure))
}