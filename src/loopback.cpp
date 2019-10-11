#include <ap_int.h>
#include <hls_stream.h>
#include <ap_axi_sdata.h>

#define DWIDTH 32

typedef qdma_axis<DWIDTH, 0, 0, 0> pkt;

extern "C" {
void loopback(hls::stream<pkt>& input, hls::stream<pkt>& output)
{
#pragma HLS interface axis port=input
#pragma HLS interface axis port=output
#pragma HLS interface ap_ctrl_none port=return
    union {
        int ival;
        float fval;
    } tmp;

    while(true) {
        pkt t = input.read();
        pkt t_out;
        ap_uint<DWIDTH> tmp_out;
        t_out.set_last(0);

        tmp.ival = t.data;
        t_out.set_data(tmp.ival+1);
        t_out.set_keep(-1);
        
        if (t.get_last()) { t_out.set_last(1); }

        output.write(t_out);
        if(t_out.get_last()) { break; }

    }
}
}

