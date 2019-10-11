#include "common.h"

extern "C" {

void property_read (
  uint64_t* mem,
  hls::stream<axiu64_t>& stream_in,
  hls::stream<axiu64_t>& stream_out,
  uint64_t& count
) {
  #pragma HLS STREAM depth=8 variable=stream_out
  #pragma HLS STREAM depth=8 variable=stream_in
  #pragma HLS INTERFACE m_axi     port=mem  name=m_axi offset=slave max_write_burst_length=64 latency=20 num_write_outstanding=32
  #pragma HLS INTERFACE axis      port=stream_out
  #pragma HLS INTERFACE axis      port=stream_in 
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
