package vegeta
import config._
import chisel3._

object Utils {
    def printA(
        weight: Seq[Seq[Seq[Seq[Int]]]],
        index: Seq[Seq[Seq[Seq[Int]]]],
        rows: Int = N_rows,
        cols: Int = N_cols,
        broadcast: Int = broadcast_factor,
        reduction: Int = reduction_factor
    ): Unit = {
        println("matrix A (COO data:index):")
        for(i <- 0 until N_rows){
            for(j <- 0 until N_cols){
                for(k <- 0 until broadcast_factor){
                    for(t <- 0 until reduction_factor){
                        print(weight(i)(j)(k)(t) + ":" + index(i)(j)(k)(t)+" ")
                    }
                }
            }
            println()
        }
    }
    def printB(
        data: Seq[Seq[Seq[Seq[Int]]]],
        rows: Int = N_rows,
        cols: Int = N_cols,
        broadcast: Int = broadcast_factor,
        reduction: Int = reduction_factor
    ): Unit = {
        println("matrix B (dense)")
        for(i <- 0 until N_rows){
            for(j <- 0 until reduction_factor){
                for(k <- 0 until blk_size){
                    for(t <- 0 until N_cols* broadcast_factor){
                        print(data(t)(i)(j)(k)+" ")
                    }
                    println()
                }
            }
        }
    }
    def compute_C(
        A_data: Seq[Seq[Seq[Seq[Int]]]],
        A_index: Seq[Seq[Seq[Seq[Int]]]],
        B_data: Seq[Seq[Seq[Seq[Int]]]],
        result: Array[Array[Int]],
        rows: Int = N_rows,
        cols: Int = N_cols,
        broadcast: Int = broadcast_factor,
        reduction: Int = reduction_factor
    ): Unit = {
        val dim = N_cols*broadcast_factor
        var n_col:Int = 0
        var broad_num:Int = 0
        var c_i_j:Int = 0
        println("matrix C (dense)")
        for(i <- 0 until N_cols*broadcast_factor){
            for(j <- 0 until N_cols*broadcast_factor){
                c_i_j = 0
                // c[i][j] is i-th row of A and j-th col of B
                n_col = i / broadcast_factor
                broad_num = i % broadcast_factor
                for(k <- 0 until N_rows){
                    for(t <- 0 until reduction_factor){
                        c_i_j = c_i_j + A_data(k)(n_col)(broad_num)(t)*B_data(j)(k)(t)(A_index(k)(n_col)(broad_num)(t))
                    }
                }
                result(i)(j) = c_i_j
            }
        }
    }
}