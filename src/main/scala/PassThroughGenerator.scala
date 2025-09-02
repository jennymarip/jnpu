import chisel3._
import Hello._
// Chisel Code, but pass in a parameter to set widths of ports
class PassthroughGenerator(width: Int) extends Module { 
  val io = IO(new Bundle {
    val in = Input(UInt(width.W))
    val out = Output(UInt(width.W))
  })
  val c = Module(new Hello)
  io.out := io.in & c.io.led
}

// Let's now generate modules with different widths
object Passthrough extends App {
  println(getVerilogString(new PassthroughGenerator(10)))
}
