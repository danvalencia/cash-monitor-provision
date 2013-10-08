name "maquinet-server"
description "Role for the Maquinet web server"
run_list %w( apt nginx mysql::server rvm::system rvm::vagrant unicorn )
