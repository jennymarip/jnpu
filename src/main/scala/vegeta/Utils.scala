package vegeta
import config._
import chisel3._

object Utils {
    def printDataLayout(
        weight: Seq[Seq[Seq[Seq[Int]]]],
        index: Seq[Seq[Seq[Seq[Int]]]],
        rows: Int = N_rows,
        cols: Int = N_cols,
        broadcast: Int = broadcast_factor,
        reduction: Int = reduction_factor
    ): Unit = {
        println("脉动阵列数据布局(data:index):")
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
}