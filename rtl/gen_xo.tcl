if {[file exists "loopback.xo"]} {
    file delete -force "loopback.xo"
}

package_xo -xo_path loopback.xo -kernel_name loopback -ip_directory ./ip/ -kernel_xml kernel.xml -kernel_files loopback.cpp
