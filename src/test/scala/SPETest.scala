package vegeta
import config._
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class SPETest extends AnyFlatSpec with ChiselScalatestTester{
    behavior of "SPE"
    it should "pass" in {
        test(new SPE) { u =>
            val rand = new Random
            u.clock.setTimeout(0)
            val weight_in = Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(100)))
            val index_in = Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(blk_size)))
            for(i <- 0 until broadcast_factor){
                for(j <- 0 until reduction_factor){
                    u.io.weight_in(i)(j).poke(weight_in(i)(j))
                    u.io.index_in(i)(j).poke(index_in(i)(j))
                }
            }
            u.clock.step(1)
            for(i <- 0 until broadcast_factor){
                for(j <- 0 until reduction_factor){
                    u.io.weight_out(i)(j).expect(weight_in(i)(j))
                    u.io.index_out(i)(j).expect(index_in(i)(j))
                }
            }
            println("preload complete!")
            val left_in = Seq.fill(reduction_factor)(Seq.fill(blk_size)(rand.nextInt(100)))
            val up_in = Seq.fill(broadcast_factor)(Seq.fill(reduction_factor)(rand.nextInt(100)))
            for(i <- 0 until broadcast_factor){
                for(j <- 0 until reduction_factor)
                    u.io.up_in(i)(j).poke(up_in(i)(j))
            }
            for(i <- 0 until reduction_factor){
                for(j <- 0 until blk_size)
                    u.io.left_in(i)(j).poke(left_in(i)(j))
            }
            u.clock.step(1)
            println("compute complete")
            for(i <- 0 until broadcast_factor){
                for(j <- 0 until reduction_factor)
                    u.io.down_out(i)(j).expect(up_in(i)(j) + weight_in(i)(j) * left_in(j)(index_in(i)(j)))
            }
        }
    }
    println("SPE SUCCESS!!")
}