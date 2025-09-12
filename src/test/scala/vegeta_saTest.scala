package vegeta
import config._
import chisel3._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec
import scala.util.Random

class vegeta_saTest extends AnyFlatSpec with ChiselScalatestTester{
    behavior of "vegeta_sa"
    it should "pass" in {
        test(new vegeta_sa) { u =>

        }
    }
    println("vegeta_sa SUCCESS!!")
}