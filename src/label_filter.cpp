#include "common.h"

extern "C" {

void label_filter (
  uint64_t* mem,
  hls::stream<axiu64_t>& stream_out,
  uint64_t& count
) {
  #pragma HLS STREAM depth=8 variable=stream_out
  #pragma HLS INTERFACE m_axi     port=mem  name=m_axi offset=slave max_write_burst_length=64 latency=20 num_write_outstanding=32
  #pragma HLS INTERFACE axis      port=stream_out   name=stream_out
  #pragma HLS INTERFACE s_axilite port=count   bundle=control offset=0x20
  #pragma HLS INTERFACE s_axilite port=mem      bundle=control offset=0x30
  #pragma HLS INTERFACE s_axilite port=return  bundle=control name=s_axi_control

  for (uint64_t i = 0; i < count;) {
  #pragma HLS PIPELINE II=1
    axiu64_t pkt;
    pkt.data = mem[i]; 
    stream_out.write(pkt);
  }
}

}
