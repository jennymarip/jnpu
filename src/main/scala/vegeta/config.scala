package vegeta
import chisel3._

object config{
    val blk_size = 4
    val broadcast_factor = 2
    val reduction_factor = 2
    val N_rows = 2
    val N_cols = 2
    // used for unstructure sparse
    val N_cols1 = 2
    val N_cols2 = 2
    val N_cols3 = 2
}