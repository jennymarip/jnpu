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
            // matrix A(COO)
            val weight_in = Seq.fill(N_rows)(Seq.fill(N_cols)(Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(10)))))
            val index_in = Seq.fill(N_rows)(Seq.fill(N_cols)(Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(blk_size)))))
            printA(weight_in, index_in)
            // matrix B(dense)
            val input_in = Seq.fill(broadcast_factor*N_cols)(Seq.fill(N_rows)(Seq.fill(reduction_factor)(Seq.fill(blk_size)(rand.nextInt(10)))))
            printB(input_in)
            val dim = N_cols*broadcast_factor
            var c = Array.fill(dim, dim)(-1)
            compute_C(weight_in, index_in, input_in, c)
            for(i <- 0 until dim){
                for(j <- 0 until dim)
                    print(c(i)(j)+" ")
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
            for(t <- 0 until 3*N_rows){
                for(i <- 0 until N_rows){
                    if(t >= i && t < N_cols*broadcast_factor+i){
                        for(j <- 0 until reduction_factor){
                            for(k <- 0 until blk_size){
                                u.io.left_in(i)(j)(k).poke(input_in(t-i)(i)(j)(k))
                            }
                        }
                    }
                }
                u.clock.step(1)
                cycleCount = cycleCount + 1
                println("第"+t+"轮:")
                for(i <- 0 until N_rows){
                    for(j <- 0 until N_cols){
                        for(k <- 0 until broadcast_factor){
                            for(a <- 0 until reduction_factor)
                                print(u.io.SPE_output(i)(j)(k)(a).peekInt()+" ")
                        }
                    }
                    println()
                }
            }
            println("compute complete!")
            println("vegeta_sa SUCCESS!!")
        }
    }
}