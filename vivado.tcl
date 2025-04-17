create_project -force mpc5
add_files -fileset sources_1 ./rtl/
add_files -fileset sim_1 ./tb/
set_property top core_tb [get_filesets sim_1]
start_gui
