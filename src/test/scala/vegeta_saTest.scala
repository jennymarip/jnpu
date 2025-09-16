package vegeta
import config._
import Utils._
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class vegeta_saTest extends AnyFlatSpec with ChiselScalatestTester{
    behavior of "vegeta_sa 1:4"
    it should "pass" in {
        test(new vegeta_sa) { u =>
            val rand = new Random
            u.clock.setTimeout(0)
            u.io.weight_load_en.poke(true.B)
            // 初始化了一个稀疏矩阵(COO)(A)
            val weight_in = Seq.fill(N_rows)(Seq.fill(N_cols)(Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(10)))))
            val index_in = Seq.fill(N_rows)(Seq.fill(N_cols)(Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(blk_size)))))
            printDataLayout(weight_in, index_in)
            // 初始化dense矩阵(B)的一列,结构化稀疏测试(1:4,2:4,4:4通用)
            val input_in = Seq.fill(N_rows)(Seq.fill(reduction_factor)(Seq.fill(blk_size)(rand.nextInt(10))))
            println("第一列数据块:")
            for(i <- 0 until N_rows){
                for(j <- 0 until reduction_factor){
                    print(" "+i+"."+j+" : ")
                    for(k <- 0 until blk_size)
                        print(input_in(i)(j)(k)+" ")
                }
                println()
            }
            // load weight
            for(t <- 0 until N_rows){
                for(i <- 0 until N_cols){
                    for(j <- 0 until broadcast_factor){
                        for(k <- 0 until reduction_factor){
                            if(u.io.weight_load_en.peekBoolean()){
                                u.io.weight_in(i)(j)(k).poke(weight_in(N_rows-t-1)(i)(j)(k))
                                u.io.index_in(i)(j)(k).poke(index_in(N_rows-t-1)(i)(j)(k))
                            }
                        }
                    }
                }
                u.clock.step(1)
            }
            u.io.weight_load_en.poke(false.B)
            println("load weight complete!")
            var cycleCount = 0
            // 测试计算过程
            for(i <- 0 until N_rows){
                for(j <- 0 until reduction_factor){
                    for(k <- 0 until blk_size)
                        u.io.left_in(i)(j)(k).poke(input_in(i)(j)(k))
                }
                u.clock.step(1)
                cycleCount = cycleCount + 1
                println("第"+i+"轮:")
                for(j <- 0 until N_rows){
                    for(k <- 0 until N_cols){
                        for(t <- 0 until broadcast_factor){
                            for(a <- 0 until reduction_factor)
                                print(u.io.SPE_output(j)(k)(t)(a).peekInt()+" ")
                        }
                    }
                    println()
                }
            }
            var res = 0
            for(i <- 0 until reduction_factor)
                res = res + u.io.output(0)(0)(i).peekInt().toInt
            var true_res = 0
            for(i <- 0 until N_rows){
                for(j <- 0 until reduction_factor)
                    true_res = true_res + weight_in(i)(0)(0)(j)*input_in(i)(j)(index_in(i)(0)(0)(j))
            }
            assert(res==true_res) // 第一列
            println("compute complete!")
            println("vegeta_sa SUCCESS!!")
        }
    }
}