name "maquinet-server"
description "Role for the Maquinet web server"
run_list %w( apt nginx rvm::system rvm::vagrant )
