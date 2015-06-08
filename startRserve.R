#!/usr/bin/env r
#
# Start Rserve from the command-line
# Adopted from install2.r
#
# Copyright (C) 2015 Marc A. Suchard
#
# Released under Apache License 2.0

suppressMessages(library(docopt))   

## configuration for docopt
doc <- "Usage: startRserve.r [-h] [-p PORT] [-c FILE]

-c --config FILE    configuration file [default: /etc/Rserv.conf]
-p --port PORT      TCP/IP port on which to serve [default: 6311]
-h --help           show this help text"

## docopt parsing
opt <- docopt(doc)

if (is.null(opt$port)) {
	opt$port <- as.integer(6311)
} else {
	opt$port <- as.integer(opt$port)
}

if (is.null(opt$config)) opt$config <- "/etc/Rserv.conf"

library(Rserve)
run.Rserve(port = opt$port, config.file = opt$config)
