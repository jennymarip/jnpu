package vegeta
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SPUTest extends AnyFlatSpec with ChiselScalatestTester{
    behavior of "SPU"
    it should "pass" in {
        test(new SPU(2)) { u =>
          u.clock.setTimeout(0)
          val weight_in = Seq(11, 24)
          val index_in = Seq(1, 2)
          for(i <- 0 until 2){
              u.io.weight_in(i).poke(weight_in(i))
              u.io.index_in(i).poke(index_in(i))
          }
          u.clock.step(1)
          val up_in = Seq(23, 34)
          for(i <- 0 until 2){
              u.io.up_in(i).poke(up_in(i))
          }
          val blk0 = Seq(10, 20, 30, 40)
          val blk1 = Seq(12, 22, 32, 42)
          val blks = Seq(blk0, blk1)
          for (i <- 0 until 2){
            for(j <- 0 until 4){
                u.io.left_in(i)(j).poke(blks(i)(j))
            }
          }
          u.clock.step(1)
          u.io.down_out(0).expect(243)
          u.io.down_out(1).expect(24*32+34)
        }
        println("SPU SUCCESS!!")
    }
}
