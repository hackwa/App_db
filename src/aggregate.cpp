#include "common.h"

extern "C" {

void aggregate (
  uint64_t* mem,
  hls::stream<axiu64_t>& stream_in,
  uint64_t& mode
) {
  #pragma HLS STREAM depth=8 variable=stream_in
  #pragma HLS INTERFACE m_axi     port=mem  name=m_axi offset=slave max_write_burst_length=64 latency=20 num_write_outstanding=32
  #pragma HLS INTERFACE axis      port=stream_in   name=stream_in
  #pragma HLS INTERFACE s_axilite port=mode    bundle=control offset=0x20
  #pragma HLS INTERFACE s_axilite port=mem      bundle=control offset=0x30
  #pragma HLS INTERFACE s_axilite port=return  bundle=control name=s_axi_control

    axiu64_t pkt;
    stream_in.read(pkt);
    mem[0] = pkt.data + mode;
}

}
