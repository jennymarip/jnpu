package vegeta
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class SPUTest extends AnyFlatSpec with ChiselScalatestTester{
    behavior of "SPU"
    it should "pass" in {
        test(new SPU(2)) { u =>
          u.clock.setTimeout(0)
          val weight_in = Seq(1, 2)
          for(i <- 0 until 2)
              u.io.weight_in(i).poke(weight_in(i))
          u.io.weight_buffer_out(0).expect(0)
          u.io.weight_buffer_out(1).expect(0)
          u.clock.step(1)
          u.io.weight_buffer_out(0).expect(1)
          u.io.weight_buffer_out(1).expect(2)
        }
        println("SPU SUCCESS!!")
    }
}
