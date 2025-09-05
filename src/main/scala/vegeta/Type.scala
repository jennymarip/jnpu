package vegeta
import chisel3._
class data_block(num : Int) extends Bundle{
    val data = Vec(num, SInt(32.W))
}