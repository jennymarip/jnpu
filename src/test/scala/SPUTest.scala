package vegeta
import config._
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class SPUTest extends AnyFlatSpec with ChiselScalatestTester{
    behavior of "SPU"
    it should "pass" in {
        test(new SPU) { u =>
          val rand = new Random
          u.clock.setTimeout(0)
          val weight_in = Seq.fill(reduction_factor)(rand.nextInt(100))
          val index_in = Seq.fill(reduction_factor)(rand.nextInt(blk_size))
          for(i <- 0 until reduction_factor){
              u.io.weight_in(i).poke(weight_in(i))
              u.io.index_in(i).poke(index_in(i))
          }
          u.clock.step(1)
          for(i <- 0 until reduction_factor){
            u.io.weight_out(i).expect(weight_in(i))
            u.io.index_out(i).expect(index_in(i))
          }
          println("preload complete!")
          val up_in = Seq.fill(reduction_factor)(rand.nextInt(100))
          for(i <- 0 until reduction_factor)
              u.io.up_in(i).poke(up_in(i))
          val blks = Seq.fill(reduction_factor)(Seq.fill(blk_size)(rand.nextInt(100)))
          for (i <- 0 until reduction_factor){
            for(j <- 0 until blk_size)
                u.io.left_in(i)(j).poke(blks(i)(j))
          }
          u.clock.step(1)
          println("compute complete")
          for (i <- 0 until reduction_factor)
            u.io.down_out(i).expect(up_in(i)+weight_in(i)*blks(i)(index_in(i)))
        }
        println("SPU SUCCESS!!")
    }
}
